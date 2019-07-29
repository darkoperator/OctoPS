function Get-OctoPSHost
{
    <#
    .SYNOPSIS
        Get information on one or more stored on a OctoPrint server.
    .DESCRIPTION
        Get information on one or more stored on a OctoPrint server.
    .EXAMPLE
        PS C:\> Get-OctoPSHost
        Get all configured printers under the current user.
    .EXAMPLE
        PS C:\> Get-OctoPSHost -Id 1,3
        Get configured printers with the Id 1 and 3 for the current user.
    .INPUTS
        Int32
    .OUTPUTS
        System.Management.Automation.PSCustomObject
    #>
    [CmdletBinding()]
    param(

        # Printer Host Id
        [Parameter(Mandatory=$false,
                   ParameterSetName = 'Index',
                   Position=0)]
        [int32[]]
        $Id = @()
    )

    Begin{}
    Process {
        $oHosts = $Global:OctoHost
        $toProcess = New-Object -TypeName System.Collections.ArrayList
        foreach($h in $oHosts) {[void]$toProcess.Add($h)}
        if ($Id.Count -gt 0) {
            foreach($i in $Id)
            {
                foreach($OHost in $oHosts) {
                    if ($OHost.Id -eq $i) {
                        Write-Verbose -Message "Pulling host with Id $($i)"
                        $OHost
                    }
                }
            }
        } else {
            # Return all sessions.
            foreach($s in $toProcess){
                $OpHost = $s
                $OpHost.pstypenames[0] = 'OctoPrint.Host'
                $OpHost
            }
        }
    }
    End{}
}