$pc = $env:COMPUTERNAME
$ver = (Get-ComputerInfo).WindowsProductName
Write-Output "You are the computer {0} running {1}" -f $pc, $ver
Write-Output "Running Test-DataSet"

Import-Module .\Test-DataSet

Test-DataSet -p0 'a' -p1 'b'
