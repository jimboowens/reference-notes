# container-developer Work Station
___
## Developer Local Environment Setup Instructions

For the container-Developer Work Station, we will implement VSCode’s Remote-Containers extension. By programmatically setting up a local test environment, the install and ramp-up procedures are vastly simplified. The following are the steps to get a local environment up and running.

 <details>
    <summary>Minimum Software and Hardware Requirements</summary>
      
      > Most up-to-date version of Microsoft Windows
      > 16 gb RAM
      > 200 gb HDD
 </details>

> Firstly, the following steps require Admin Access to set up. If you do not have it, this will fail. 

Any of the following steps may require logging back in, restarting, or both one or more times.

# Steps:
___
## 1: Make Required Directories
Make the: `C:\workspaces\` directory.

## 2: Verify Administrator Privileges and Access to Ancillary Tools
Again, be sure you have administrator privileges.

## 3: Install WSL2
[Install the Windows Subsystem for Linux][install-win-10] (WSL2)(Admin). Docker Desktop needs this. 

## 4: Install Docker Desktop
[Download Docker Desktop][install-docker-desktop] (Admin) to the `workspaces` directory. The current version as of the last update of this form is `4.2.0`. There is no need to register an account. When you find Docker Desktop in your hidden icons of your Windows Toolbar, right-click it and enter the Settings. Verify you have the checkbox for `Use the WSL2 based engine` checked, and  the Docker VM has started. 

## 5: Install Chocolatey
[Install chocolatey][install-choco] (Admin). You should be able to run the following script in an Admin Powershell, but if not, the reference should work as well. 

```
> Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

In an elevated powershell, execute the command: `> choco install -g git`

## 6: Install SQuirrel and Connect to Pre-Configured Sql Server Database
> Note: Please verify the database to be connected exists and is ready to be used before starting this step.

[Install SQuirreL][install-squirrel] (Admin) to workspaces. When you activate it, click on the Drivers tab (Left Side, not dropdown menu), and scroll to the jDTS Microsoft SQL Driver. Click on the Extra Class Path, select Add Path, and add a Java Runtime (in `workspaces`). This should now have a green or blue check in the SQuirrel UI, no longer the red x. Click OK, and navigate to Aliases. Click the + sign, and select: 

```sql
Name: msaqlserver <db-name>
Driver: jDTS Microsoft SQL
URL: jdbc:jdts:sqlserver://<server-FQDN>:<server-port>/<db-name>;transactionIsolation=0
 ```
 
The username and /or password may change, so reference the secrets where they are stored for your connection.

## 7: Install VSCode and Remote-Containers
[Install VS Code][install-vscode]. Download the newest version. It is not listed here, as updates are common. It is exceedingly popular (over 50% usage across some developer groups), and has support for many extensions. Extensions may be added, but some conflict with defaulted ones (e.g. redhat-java). This may cause programs and consequently VSCode to crash intermittently. Install extras at your own risk. That being said, there are tons of helpful extensions. 

Be sure to install the Remote - Containers extension. 

## 8: Enable Internet Networking Connectivity for WSL2 Terminal, Clone this Repository, configure PAT, and Open in VSCode
 > Note: [These steps][resolv-conf] are required to connect to DNS calls outisde the private DNS when on VPN, but are not required to connect to github if and when off the network.
 
Open an Ubuntu terminal and execute: 

```
$ cd /mnt/c/workspaces/..
$ git config -g http.sslverify false
```

A Personal Access Token (PAT) will be necessary in order to clone any github repositories within github SCM. Verify the PAT exists, is authorized with the necessary permissions to fetch and push changes to a given repository, and store the PAT expiration date. When the PAT expires, a new one will need to be administered.

> Note: SSH is also configurable, but is not covered in this list of steps at this time.

```
$ git clone https://<personal-access-token>@github.com/<organization>/<container-repo>
$ echo <personal-access-token> >> ./<container-repo>/workspaces/github_token
$ code ./<container-repo>
``` 

The developer space should load, and VS Code should realize this is a Docker project with a Dockerfile. Accept the prompt to reopen in a container. While loading, click details to watch the container start**. This likely will take some time. The Dockerfile must execute many commands. When your container is up, navigate to the `workspace-in-container.code-workspace`. Accept the prompt to open the workspace inside the container. 

## 9: Download, Unzip, and chmod related server runtime platform
We need to download any related runtime in order to be able to run the backend module. When this is downloaded, it has to be saved in the `C:\workspaces\<container-repo>` in your local machine’s directory. This will allow the remote container to see it.

## 10: Run Jobs and Get Coding!
Tasks should be loaded correctly. Press `CTRL+SHIFT+B` and look for the necessary tasks.

## Prologue
___

When these tasks build, hop over to your chrome browser and go to `localhost:<port>` to see your very own local instance of the program. Happy coding! 

Note: you will have to log into `git` to be able to commit. Enter the following (after modifying) into your terminal:

```bash
git config --global user.name "your name here"
git config --global user.email "your_email@example.com"
git config --global user.password "your_password here"
```

For extra credit, you can learn more about containers and what all they can do [here][extra-credit].

> ** Note: If you encounter this error: `stdin closed!` right after a `cat /etc/passwd`, it is probably because your developer devcontainer is not configured as is needed, and must be deleted. After deleting, rebuild the container in VSCode and things should be fine. It may also be you downloaded the git repository through Powershell. It needs to be downloaded via a linux terminal, as the Dockerfile entrypoint scripting fails otherwise. that may be commented out if need be, but it would be preferable were it not the case. You may also need to restart your machine.

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - [so])

[exra-credit]: <https://code.visualstudio.com/docs/remote/containers>
[install-choco]: <https://chocolatey.org/docs/installation>
[install-docker-desktop]:<https://docs.docker.com/desktop/windows/release-notes/>
[install-squirrel]: <http://squirrel-sql.sourceforge.net/>
[install-vscode]: <https://code.visualstudio.com/download>
[install-win-10]:<https://docs.microsoft.com/en-us/windows/wsl/install-win10>
[so]:<http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax>
