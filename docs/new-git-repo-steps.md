# Git commands 

1. Initializing a folder:
    ```bash
    git init
    ```

2. Add remote git server to local git repo
    ```bash
    git remote add origin https://github.com/shravanchava406/devops.git
    ```
3. Renaming the default git branch to `main`:
    ```bash
    git branch -M main
    ```
4. Moving the local file changes to git Staging area:
    ```bash
    git add . 
    ```
5. Committing the changes in the staging area with a message:
    ```bash
    git commit -m "Add EC2 configuration files"
    ```
6. `Optional`: To check the git commit history:
    ```bash
    git log
    ``` 

7. Publishing and pushing the `main` branch to remote repo(github):
    ```bash
    git push -u origin main
    ```