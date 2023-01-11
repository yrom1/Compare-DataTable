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

function Echo-Query {
    param(
        [string]$query
    )
    $SERVERNAME = '{0}\SQLEXPRESS' -f [System.Net.Dns]::GetHostName()
    $DATABASENAME = 'test' # :P lol
    $CONN = New-Object System.Data.SqlClient.SqlConnection
    $CONN.ConnectionString = "Server={0};Database={1};Integrated Security=True" -f $SERVERNAME, $DATABASENAME
    $CONN.Open()
    $ADAPTER = New-Object System.Data.SqlClient.SqlDataAdapter
    $CMD = $query
    $ADAPTER.SelectCommand = New-Object System.Data.SqlClient.SqlCommand($CMD, $CONN)
    $DATASET = New-Object System.Data.DataSet
    $RESULT = $ADAPTER.Fill($DATASET)
    $CONN.Close()
    # TODO so this is bad, if you have a DataSet and just do
    #      .Tables and it happens to just have one DataTable
    #      this just returns that table...
    $table = $DATASET.Tables # NOTE I removed trailing [0] idk why this works rn it was returning object[] with the [0]...
    return $table
}

$table1 = Echo-Query 'SELECT 1 a UNION SELECT 2 a'
Write-Host $table1

$table2 = Echo-Query 'SELECT 1 a UNION SELECT 3 a'
Write-Host $table2

Import-Module .\Compare-DataTable -Force
$ans = Compare-DataTable -ReferenceDataTable $table1 -DifferenceDataTable $table2
Write-Output $ans
