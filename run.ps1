Write-Output "You are the computer {0} running {1}" -f $env:COMPUTERNAME, (Get-ComputerInfo).WindowsProductName
Write-Output Running '`pwsh main.ps1`'
.\main.ps1
