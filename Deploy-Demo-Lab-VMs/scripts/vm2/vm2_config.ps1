# Set Execution Policy - This will allow scrit to run on VM
Set-ExecutionPolicy Bypass -Scope Process -Force 
# Install Chocolatey - Windows package manager used to instlal applications
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install crystaldiskmark -y
choco install googlechrome -y
choco install putty -y
choco install notepadplusplus -y
choco install winscp -y
choco install sysinternals -y
choco install bginfo -y
choco install azure-cli -y
choco install microsoftazurestorageexplorer -y
choco install vscode -y
# Setup and partition sysvol disk
Get-Disk | Where-Object partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel 'Sysvol' -Confirm:$false 