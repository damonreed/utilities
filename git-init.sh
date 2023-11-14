REMOTE = "{{new-remote}}"

mkdir $REMOTE
cd $REMOTE
git init
git remote add origin https://github.com/damonreed/$REMOTE
git add .
git commit -m "Initial commit"
git push origin master
