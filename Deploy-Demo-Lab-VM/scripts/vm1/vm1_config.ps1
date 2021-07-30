# Set Execution Policy - This will allow scrit to run on VM
Set-ExecutionPolicy Bypass -Scope Process -Force 
# Install Chocolatey - Windows package manager used to instlal applications
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install googlechrome -y
choco install putty -y
choco install notepadplusplus -y
choco install winscp -y
choco install sysinternals -y
choco install bginfo -y
choco install azure-cli -y
choco install microsoftazurestorageexplorer -y
choco install vscode -y
# Download Scripts - These scripts are use post VM build to setup and configure the domain
New-Item -Path "c:\" -Name "DemoLab" -ItemType "directory" -Force
# Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jakewalsh90/Terraform-Azure/main/Dual-Region-Azure-BaseLab/PowerShell/DC1/baselab_DomainSetup.ps1" -OutFile "C:\DemoLab\baselab_DomainSetup.ps1"
# Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jakewalsh90/Terraform-Azure/main/Dual-Region-Azure-BaseLab/PowerShell/DC1/baselab_LabStructure.ps1" -OutFile "C:\DemoLab\baselab_LabStructure.ps1"
# Setup and partition sysvol disk
Get-Disk | Where partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel 'Sysvol' -Confirm:$false 
# Allow Ping
Set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" -enabled True
Set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv6-In)" -enabled True
# Install Windows features - ADDS and DNS
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Install-windowsfeature -name DNS -IncludeManagementTools
Clear-DnsClientCache