@echo off

:: Check if Git is available
echo Checking if Git is available...
git --version >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Git not found. Please ensure Git is installed and added to system PATH.
    exit /b 1
)

echo Git is installed.

:: Initialize Git repository if not exists
if not exist ".git" (
    echo Initializing Git repository...
    git init
)

:: Add HTML files
echo Adding HTML files...
git add *.html
git add x/index.html

:: Add configuration files
git add package.json
git add taro.config.js

:: Add Markdown files
git add *.md

:: Configure user settings
git config user.name "GitHub User"
git config user.email "user@example.com"

:: Commit changes
echo Committing changes...
git commit -m "Add rural talent training course website files" 2>nul || echo No changes to commit

echo Git setup completed!