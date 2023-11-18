##
## repo-init.sh
##

export REPO="linux"
export DESC="Notes and scripts for using linux"

# Set up directory
mkdir $REPO
cd $REPO
cat > README.md << EOF
# $REPO
$DESC
EOF

# Create repo on github
gh auth login
gh repo list
gh repo create $REPO -d $DESC --public

# Create empty local repo w README and push to github
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin git@github.com:damonreed/${REPO}.git
git push -u origin main
