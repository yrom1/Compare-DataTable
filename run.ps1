$pc = $env:COMPUTERNAME
$ver = (Get-ComputerInfo).WindowsProductName
$hi = "You are the computer {0} running {1}" -f $pc, $ver
Write-host $hi

try {
    $ErrorActionPreference = "Stop"
    Write-Output "Testing Test-DataSet"
    .\test.ps1
}
catch {
    # $ex = $_
    Write-Output "Test Failure!"
    throw
}
Write-Output "Test Success!"

Write-Output "Running Test-DataSet Example"
Import-Module .\Test-DataSet
Test-DataSet -p0 'a' -p1 'b'
