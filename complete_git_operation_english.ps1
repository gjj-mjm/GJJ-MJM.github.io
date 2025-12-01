# Complete Git commit and push script

# Set Git path to environment variable
Write-Host "Setting Git path..."
$env:PATH = "C:\Program Files\Git\bin;C:\Program Files\Git\cmd;$env:PATH"

# Verify Git installation
Write-Host "\nChecking Git version..."
git --version

# Set Git user information
Write-Host "\nSetting Git user information..."
git config --local user.name "GitHub User"
git config --local user.email "user@example.com"

# Ensure remote repository is configured
Write-Host "\nEnsuring remote repository is configured..."
git remote remove origin -f 2>$null
git remote add origin git@github.com:gjj-mjm/GJJ-MJM.github.io.git
git remote -v

# Add all files to staging area
Write-Host "\nAdding all files to staging area..."
git add .

# Show current status
Write-Host "\nCurrent Git status:"
git status

# Execute commit
Write-Host "\nExecuting commit..."
git commit -m "Initialize repository with rural talent mini-program files"

# Push to remote repository
Write-Host "\nPushing to GitHub..."
git push -u origin master

Write-Host "\nGit operations completed!"
Write-Host "Please check GitHub repository to confirm files are successfully uploaded."