# Simplified Git fix and commit script

# Set Git path to environment variable
$env:PATH = "C:\Program Files\Git\bin;C:\Program Files\Git\cmd;$env:PATH"

# Verify Git installation
git --version

# Set Git user information
git config --local user.name "GitHub User"
git config --local user.email "user@example.com"

# Ensure remote repository is configured
git remote remove origin -f 2>$null
git remote add origin git@github.com:gjj-mjm/GJJ-MJM.github.io.git
git remote -v

# List untracked files
git status

# Create .gitignore file if not exists
if (!(Test-Path ".gitignore")) {
    Write-Host "Creating .gitignore file..."
    "# Node.js modules\nnode_modules/\n\n# IDE files\n.idea/\n.vscode/\n\n# Build output\ndist/\nbuild/\n\n# Environment variables\n.env\n.env.local\n.env.*.local\n\n# Logs\nlogs\n*.log\nnpm-debug.log*\nyarn-debug.log*\nyarn-error.log*\n\n# OS generated files\n.DS_Store\n.DS_Store?\n._*\n.Spotlight-V100\n.Trashes\nehthumbs.db\nThumbs.db" | Out-File ".gitignore" -Encoding utf8
}

# Add specific project files that matter
Write-Host "\nAdding key project files..."
git add .gitignore package.json taro.config.js index.js

# Show status after adding
git status

# Execute commit
git commit -m "Add core mini-program files"

# Push to main branch (GitHub uses main as default now)
git push -u origin main