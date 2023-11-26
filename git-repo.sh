export REPO="{{REPO_NAME}}"

mkdir $REPO
cd $REPO
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin git@github.com:damonreed/${REPO}.git
git push -u origin main
