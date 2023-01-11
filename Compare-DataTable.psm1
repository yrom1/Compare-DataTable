function Compare-DataTable {
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $True, Position = 1)][System.Data.DataTable]$ReferenceDataTable,
        [Parameter(Mandatory = $True, Position = 2)][System.Data.DataTable]$DifferenceDataTable
    )
    <#
    I want to show the incorrect changes in the test DataTable as what has been added:
    $ cat file1
    line1
    line2
    line3

    $ cat file2
    line1
    line2
    line4

    $ diff file1 file2
    2c2
    < line3
    ---
    > line4
    #>

    Write-Host "DT1"
    $dataTable1 = $ReferenceDataTable
    Write-Host $ReferenceDataTable
    Write-Host "DT2"
    $dataTable2 = $DifferenceDataTable
    Write-Host $DifferenceDataTable

    foreach ($row1 in $dataTable1.Rows) {
        $row2 = $dataTable2.Rows | Where-Object { $_[0] -eq $row1[0] }
        if ($row2) {
            foreach ($column in $dataTable1.Columns) {
                if ($row1[$column] -ne $row2[$column]) {
                    Write-Host "Difference found in column $column. Value in dataTable1: $($row1[$column]), value in dataTable2: $($row2[$column])"
                }
            }
        }
        else {
            Write-Host "No matching row found in dataTable2 for $($row1[0])"
        }
    }
    return $True
}

Export-ModuleMember -Function Compare-DataTable
