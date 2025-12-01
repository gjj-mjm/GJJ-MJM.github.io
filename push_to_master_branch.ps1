# Script to push to master branch correctly

# Set Git path to environment variable
$env:PATH = "C:\Program Files\Git\bin;C:\Program Files\Git\cmd;$env:PATH"

# Show current branch
echo "Current branch:"
git branch

# Push to master branch
echo "\nPushing to master branch..."
git push -u origin master