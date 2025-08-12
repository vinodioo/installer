# windows-install.ps1
# One-click installer for AI video agent and n8n automation

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Please run this script as Administrator. Right-click PowerShell and select 'Run as Administrator'."
    exit
}

# Check if WSL is enabled
Write-Host "Checking WSL status..."
$wslStatus = wsl --status 2>$null
if (-not $wslStatus) {
    Write-Host "Enabling WSL2..."
    wsl --install
    wsl --set-default-version 2
} else {
    Write-Host "WSL2 already enabled."
}

# Install Ubuntu if not already installed
Write-Host "Installing Ubuntu..."
$wslList = wsl --list --all
if (-not ($wslList -match "Ubuntu")) {
    wsl --install -d Ubuntu
} else {
    Write-Host "Ubuntu already installed."
}

# Wait for Ubuntu to be ready
Start-Sleep -Seconds 10

# Run Ubuntu setup script
Write-Host "Running Ubuntu setup..."
wsl -d Ubuntu bash -c "wget https://raw.githubusercontent.com/vinodioo/installer/main/ubuntu-setup.sh && chmod +x ubuntu-setup.sh && ./ubuntu-setup.sh"

Write-Host "Setup complete! Access the n8n dashboard at http://localhost:5678"
Write-Host "If the dashboard is not accessible, run 'wsl -d Ubuntu' and check logs with 'docker logs n8n'."
