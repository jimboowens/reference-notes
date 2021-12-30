# Steps to migrate from on-prem git SCM instance to GitHub

This is a step-by-step guide for migrating a Jenkins pipeline (specifically, multibranch) enabled repository currently located in an on-prem server to GitHub.

As a result, this approach was devised.

1. In GitHub, create a new repository with the same name as that of the repository you wish to migrate from GOGS. Save the URL for use later.
2. Configure a Personal Access Token, as outlined [here](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).
    - Be sure to save the token in a secure place, as this will be needed to allow the repository to be cloned into a development environment, as well as any repository pushes or pulls. GitHub will not show the string again. If the token is lost, it would have to be deauthorized and replaced.
    - Microsoft outlines reasons for this step [here](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/).
    - The construction of the URL for a given repository is as follows: 
        ``` 
            'https://github.com/<organization>/.../' + REPO + '.git'
        ```
    - This will have to be authorized via github before configuring a Jenkins credential with the token.
    - There will be a number of tokens necessary for developers, and it would be best practice to configure tokens for each user with access to a given project. 
    - At the time of the writing of this documentation, there is no known solution for github authentication apart from a developer generated Personal Access Token, and this documentation will be updated at such time as that solution is found.
3. Navigate to your Jenkins Project, and then configure a new Credential; the kind of which being 'Username with password'. The username will be `<organization>`, and the password will be the aforementioned access token.

![image_not_found](https://github.com/<organization>/<repository>/blob/master/images/github_access_token_Jenkins.jpg?raw=true)

4. Once the token and URL are set, the remote origin will have to be reset. 
    - Then, navigate to the multibranch pipeline and follow the pipeline syntax link. Select the checkout option, and follow the steps Jenkins provides.
    - replace the repository URL and Source Control variables with the saved URL and Jenkins credentials, as outlined [here](https://github.com/<organization>/<repository>/blob/master/docs/jenkins-mgmt/Jenkinsfile-sample-github)
5. Update the Jenkinsfile to reference the new new github URL.
    - Before progressing, be sure to be in the default branch and execute `git pull`. Also, if there are any branches needing to be migrated as well, be sure the local .git directory has that data. 
    - Update the repo, then migrate it by executing the command:
    ```
        git remote set-url <origin> <'https://' + PERSONAL_ACCESS_TOKEN + '@github.com/<organization>' + REPO + '.git'>
     ```
    - Verify the new remote origin is set with `git remote -v`. This should show the push and pull URLS reflect the origin with the Personal Access Token
    - Source control should register there are unstaged changes, and updating the new repository in GitHub should react just as was with GOGS. There are few exceptions, most notably the need to push branches not yet merged to the default branch.

Now the Jenkins pipeline is transitioned to pull source control data from GitHub AND the repository is up-to-date with the repository in GOGS, any subsequent compiles and pushes to the registry will come from the new repo in GitHub, not the former source of truth in GOGS.

Please reach out with questions, comments, or concerns, if any. Thanks!

** P.S. I am also looking to better this approach, and follow best practices whenever I can. If you see anything in this guide you feel could be improved upon or could be a potential vulnerability, please reach out and let me know. Thank you again! **
