# Set Execution Policy - This will allow scrit to run on VM
Set-ExecutionPolicy Bypass -Scope Process -Force 
# Install Chocolatey - Windows applications package manager
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# Install the following apps
choco install crystaldiskmark -y
choco install googlechrome -y
choco install putty -y
choco install notepadplusplus -y
choco install winscp -y
# choco install sysinternals -y
# choco install bginfo -y
# choco install azure-cli -y
# choco install microsoftazurestorageexplorer -y
# choco install vscode -y