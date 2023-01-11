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

Write-Output "Last Row:", $RESULT
Write-Output "DataSet", $DATASET
