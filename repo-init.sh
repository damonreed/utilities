##
## repo-init.sh
##
export REPO="py-packaging-tutorial"
export DESC="Official Python Packaging Tutorial - my installation and notes"

# Set up directory
mkdir $REPO
cd $REPO
cat > README.md << EOF
# $REPO
$DESC
EOF
curl -o .gitignore https://raw.githubusercontent.com/damonreed/utilities/main/.gitignore
curl -o LICENSE https://raw.githubusercontent.com/damonreed/utilities/main/LICENSE


# Create repo on github
gh auth login
gh repo list
gh repo create $REPO -d "$DESC" --public

# Create empty local repo w base files and push to github
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin git@github.com:damonreed/${REPO}.git
git push -u origin main
