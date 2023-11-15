export REMOTE="gcp"
# mkdir $REMOTE
# cd $REMOTE
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin git@github.com:damonreed/gcp.git
git push -u origin main
