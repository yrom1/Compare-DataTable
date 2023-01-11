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

$SERVERNAME = '{0}\SQLEXPRESS' -f [System.Net.Dns]::GetHostName()
$DATABASENAME = 'test'
$CONN = New-Object System.Data.SqlClient.SqlConnection
$CONN.ConnectionString = "Server={0};Database={1};Integrated Security=True" -f $SERVERNAME, $DATABASENAME
$CONN.Open()
$ADAPTER = New-Object System.Data.SqlClient.SqlDataAdapter
$CMD = 'SELECT 1 a UNION SELECT 2 a'
$ADAPTER.SelectCommand = New-Object System.Data.SqlClient.SqlCommand($CMD, $CONN)
$DATASET = New-Object System.Data.DataSet
$RESULT = $ADAPTER.Fill($DATASET)
$CONN.Close()
# Write-Host "Last Row:", $RESULT
# Write-Host "DataSet:", $DATASET | Format-Table # FT unneeded

Import-Module .\Compare-DataTable -Force
# TODO so this is bad, if you have a DataSet and just do
#      .Tables and it happens to just have one DataTable
#      this just returns that table...
$table = $DATASET.Tables[0]
Write-host $table
$ans = Compare-DataTable -ReferenceDataTable $table -DifferenceDataTable $table
Write-Output $ans
