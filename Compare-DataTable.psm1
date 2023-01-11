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
    Write-Host $ReferenceDataTable
    Write-Host "DT2"
    Write-Host $DifferenceDataTable

    if ($ReferenceDataTable.Rows.Count -ne $DifferenceDataTable.Rows.Count) {
        Write-Host "Unequal Row.Count!"
        return $False
    }
    if ($ReferenceDataTable.Columns.Count -ne $DifferenceDataTable.Columns.Count) {
        Write-Host "Unequal Columns.Count!"
        return $False
    }

    $DiffFound = $False
    for ($i = 0; $i -lt $ReferenceDataTable.Rows.Count; $i++) {
        for ($j = 0; $j -lt $ReferenceDataTable.Columns.Count; $j++) {
            # Do something with the cell value
            $ReferenceValue = $ReferenceDataTable.Rows[$i][$j]
            $DifferenceValue = $DifferenceDataTable.Rows[$i][$j]
            Write-Host $ReferenceValue $DifferenceValue
            # TODO how do i generic compare the various non-int types?
            if ($ReferenceValue -ne $DifferenceDataTable) {
                Write-Host "Found difference in row values ({0},{1}) (i,j): <R {3}, >D {4}" -f $i, $j, $ReferenceValue, $DifferenceValue
                $DiffFound = $True
            }
        }
    }
    # $DiffFound = $True
    # Write-Host "Difference found in column $column. Value in dataTable1: $($row1[$column]), value in dataTable2: $($row2[$column])"
    # $DiffFound = $True
    # Write-Host "No matching row found in dataTable2 for $($row1[0])"
    return $DiffFound
}

Export-ModuleMember -Function Compare-DataTable
