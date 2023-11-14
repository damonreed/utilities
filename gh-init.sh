REPO = "{{REPO_NAME}}"
DESC = "{{REPO}}"

gh auth login
gh repo list
gh repo create $REPO -d $DESC --public