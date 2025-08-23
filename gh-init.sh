#
# gh-init - set up and use the github gh CLI tool
#

# For best results, replace this
REPO = "{{REPO_NAME}}"
DESC = "{{REPO_DESC}}"

# Get the utility on MacOS - windows losers GTFO
# brew install gh

gh auth login
gh repo list

gh repo create $REPO -d $DESC --public
# gh repo create $REPO -d $DESC --private
