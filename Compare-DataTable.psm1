function Compare-DataTable {
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $True, Position = 1)][System.Data.DataTable]$ReferenceDataTable,
        [Parameter(Mandatory = $True, Position = 2)][System.Data.DataTable]$DifferenceDataTable
    )
    <#
    $ cat file1
    line1
    line2
    line3
    $ cat file2
    line1
    line2
    line4
    $ diff file1 file2
    3c3
    < line3
    ---
    > line4

    $ diff file1 file2
    3c3
    < line3
    ---
    > line4
    $ echo $?
    1
    $ diff file1 file1
    $ echo $?
    0

    > [convert]::toint32($false)
    0
    > [convert]::toint32($true)
    1
    #>

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
            # $fmt = "INDEX {0},{1}" -f $i, $j
            # Write-Host $fmt
            # Do something with the cell value
            $ReferenceValue = $ReferenceDataTable.Rows[$i][$j]
            $DifferenceValue = $DifferenceDataTable.Rows[$i][$j]
            # TODO how do i generic compare the various non-int types?
            if ($ReferenceValue -ne $DifferenceValue) {
                # Write-Host $ReferenceValue $ReferenceValue.gettype() $DifferenceValue $DifferenceValue.gettype()
                $fmt = "Found difference @ (i={0},j={1}): <R {2}, >D {3}" -f $i, $j, $ReferenceValue, $DifferenceValue
                Write-Host $fmt
                $DiffFound = $True
            }
        }
    }
    return $DiffFound
}

Export-ModuleMember -Function Compare-DataTable
