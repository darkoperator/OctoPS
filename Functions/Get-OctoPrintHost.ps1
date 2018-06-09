function Get-OctoPrintHost
{
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
            foreach($s in $toProcess){$s}
        }
    }
    End{}
}