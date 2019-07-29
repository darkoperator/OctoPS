function Remove-OctoPSHost
{
    <#
    .SYNOPSIS
        Remove a specified OctoPrint from stored host using the Host Id.
    .DESCRIPTION
        Remove a specified OctoPrint from stored host using the Host Id.
    .EXAMPLE
        PS C:\> Remove-OctoPSHost -Id 2
        Remove a configured host with Id 2
    .INPUTS
        Int32
    #>
    [CmdletBinding()]
    param(

        # OctoPrint Host  Id
        [Parameter(Mandatory=$true,
                   Position=0,
                   ValueFromPipelineByPropertyName=$true)]
        [int32[]]
        $Id
    )

    Begin{}
    Process {
        # Finding and saving sessions in to a different Array so they can be
        # removed from the main one so as to not generate an modification
        # error for a collection in use.
        $connections = $Global:OctoHost
        $toremove = New-Object -TypeName System.Collections.ArrayList

        if ($Id.Count -gt 0) {
            foreach($i in $Id) {
                Write-Verbose -Message "Removing Host with Id $($i)"

                foreach($Connection in $connections) {
                    if ($Connection.Id -eq $i) {
                        [void]$toremove.Add($Connection)
                    }
                }
            }

            foreach($Connection in $toremove) {
                $Global:OctoHost.Remove($Connection)
            }
         }
         Set-Content -Path $Global:OctoPSConfigPath  -Value (ConvertTo-Json -InputObject $Global:OctoHost )
    }
    End{}
}