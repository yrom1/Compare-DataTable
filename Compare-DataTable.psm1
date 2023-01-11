function Compare-DataTable {
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $True, Position = 0)][System.Data.DataTable]$DataTable0,
        [Parameter(Mandatory = $True, Position = 1)][System.Data.DataTable]$DataTable1
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
    return $True
}

Export-ModuleMember -Function Compare-DataTable
