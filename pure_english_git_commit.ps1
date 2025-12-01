# Simple Git commit script

Write-Host "Starting Git commit operations..."

# Set Git user name and email
git config --local user.name "GitHub User"
git config --local user.email "user@example.com"

# Ensure remote repository is configured
git remote remove origin -f 2>$null
git remote add origin git@github.com:gjj-mjm/GJJ-MJM.github.io.git

# Add all files to staging area
Write-Host "Adding all files to staging area..."
git add .

# Show current status
Write-Host "Current Git status:"
git status

# Execute commit
Write-Host "Executing commit..."
git commit -m "Initialize repository with rural talent mini-program files"

# Push to remote repository
Write-Host "Pushing to GitHub..."
git push -u origin master

Write-Host "Git commit and push operations completed!"