#!/bin/bash

function write {
    echo "$1" >> "$2" 
}

touch /tmp/workspace-git-downloader.log

TMPLOG='/tmp/workspace-git-downloader.log'
ORGANIZATION='organization'

write "`date +%R\ `workspace git downloader started" "$TMPLOG"

BASEURL="https://${@/workspaces/github_token}@github.com/${ORGANIZATION}/"

for REPO in $(cat /workspaces/workspace-in-container.code-workspace | grep '"path": "[^\.]' | cut -d'/' -f3 | sed 's/.$//'); do
    DIR="/development/$REPO"
    if [ ! -d "$DIR" ]; then
        write "`date +%R\ `file $REPO at $DIR does not exist, pulling git repo" "$TMPLOG"
        git clone "$BASEURL/$REPO.git" "$DIR"
        if [ -f "$DIR/pom.xml" ]; then 
            write "`date +%R\ `run mvn -f $DIR clean install -DskipTests, find log in /tmp/$REPO-install.log" "$TMPLOG"
            mvn -f "$DIR/" clean install -DskipTests | tee /tmp/"$REPO"-mvn-install.log
        elif [ -f "$DIR/package.json" ]; then 
            write "`date +%R\ `run npm --prefix $DIR/ ci, find install log in /tmp/$REPO-install.log" "$TMPLOG"
            npm --prefix "$DIR" ci | tee /tmp/"$REPO"-npm-install.log
        else 
            write "`date +%R\ `no packages to install, moving on" "$TMPLOG"
        fi
    else
        write "`date +%R\ `file $REPO at $DIR exists, not pulling" "$TMPLOG"
    fi
done
write "`date +%R\ `git cloning and package installation complete" "$TMPLOG"