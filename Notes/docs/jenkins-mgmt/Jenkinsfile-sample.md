
# Jenkins to M365 Connector Custom Instructions 

It is possible to link a given Jenkins project to a Teams Channel and update that team as pipeline builds progress. The following is a step-by-step instruction for builds, including those with multi-branch pipelines. Currently, the M365 Connector in the Jenkins UI does not support multi-branch pipelines, so the call must be made in the Jenkins script.  

# Steps

## Step 1
Create or navigate to the Team on which you wish to dedicate a channel to Jenkins updates. I named my specific Channel `Jenkins updates`. Click the `+`, then `More Apps` and input `Jenkins`. 

![image_not_found](https://github.com/organization/repository-name/blob/master/images/add-jenkins-app-in-teams.jpg?raw=true)

## Step 2

Once selected, follow the instructions and be sure to save the Webhook URL. I simply pasted it to the initial success post from Jenkins when the connector is activated from the Team Channel side. 

## Step 3

If you are wanting to integrate this plug-in into your single-branched pipeline, you may follow the general Microsoft documentation. Otherwise, you must continue the following steps. 

## Step 4

The UI for the Jenkins pipeline configuration is only supported for single pipeline builds, so we must now progress to modifying the Jenkinsfile a given project uses for its build. This [M365 documentation](https://www.jenkins.io/doc/pipeline/steps/Office-365-Connector/) is helpful.  

## Step 5

You must define the scmVars, the webhookURL, and call various variables and values within them to build a helpful message 

A. Above any declared or scripted steps, first `def scmVars`. 

B. Above any declared or scripted steps, first `def webhookURL="https://organization.webhook.office.com/webhookb2/..."`

C. Before calling the M365 Connector, set
    
        scmVars = checkout([$class: 'GitSCM', 
            branches: [[name: "refs/heads/${branchLabel}"]], 
            browser: [$class: 'GogsGit', repoUrl: ''], 
            doGenerateSubmoduleConfigurations: false, 
            extensions: [[ $class: 'CleanBeforeCheckout']], 
            submoduleCfg: [], 
            userRemoteConfigs: [[credentialsId: 'jenkins-git', 
            url: 'https://git.organization.com/team/repository-name.git']]]
        )
     

D. You may either create a stage for the M365 notification, or call the connector within logic based on what credentials are available. e.g I have logic withing the rollout as to whether a branch is related to an OCP instance, and in case it is, the pipeline has different duties. Our team only wants to be notified of builds that make it to the rollout stage, and are of branchLabel == ‘master’. Once inside, the code is as follows:  

    
        commit_message = sh(
            script: "git log -1 --format=%B ${scmVars.GIT_COMMIT}", returnStdout: true
        ).trim()
        office365ConnectorSend (
        webhookUrl: "${webhookURL}",
        color: "${currentBuild.currentResult} == 'SUCCESS' ? '00ff00' : 'ff0000'",
        factDefinitions:[
            [ name:'Commit Message', template:"${commit_message}"],
            [ name:'Pipeline Duration', template:"${currentBuild.durationString - ' and counting'}"]
        ]
    )

## Notes

The current Build has many other attributes, and the list can be found [here](https://kb.novaordis.com/index.php/Jenkins_currentBuild). You may also get some insight as to how you may customize your notifications [here](https://github.com/jenkinsci/office-365-connector-plugin). 

You may review a sample Jenkinsfile for [git](https://github.com/organization/repository-name/blob/master/docs/jenkins-mgmt/Jenkinsfile-sample-github) or [gogs](https://github.com/organization/repository-name/blob/master/docs/jenkins-mgmt/Jenkinsfile-sample-gogs) for a more concrete example of where to place what

Below is an example of the cards received in the connected Jenkins Channel:

![image_not_found](https://github.com/organization/repository-name/blob/master/images/jenkins-teams-notification.jpg?raw=true)

Please reach out if you have any issues! Thank you

