function Set-OctoPSHost {
    <#
    .SYNOPSIS
        Saves a new OctoPrint host for use of the cmdlets.
    .DESCRIPTION
        Saves a new OctoPrint host for use of the cmdlets. On *nix hosts it is stored in ~/.octops/printservers.json
        on Windows hosts it is stored in $($Env:AppData)\.octops\printservers.json.
    .EXAMPLE
        PS C:\> Set-OctoPSHost -Name CR-10_01 -Uri https://192.168.1.20 -ApiKey 5DC40C3C5BFB41709AC37D3DA558BA28
        Saves a new printer in the configuration called CR-10_01
    .INPUTS
        String
    #>
    [CmdletBinding(DefaultParameterSetName = 'New')]
    param (
        # Friendly name for OctoPi Server
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'New')]
        [string]
        $Name,

        # URI to the OctoPrint host in <http|https>://<host>:<port> format
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'New')]
        [URI]
        $Uri,

        # API Key
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'New')]
        [String]
        $ApiKey
    )
    
    begin {
    }
    
    process {
        $HostProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary

        $HostIndex = ($Global:OctoHost | select-object -Last 1).Id + 1
        $HostProps.Add('Id', $HostIndex)
        $HostProps.Add('Name',$Name)
        $HostProps.Add('Uri',$Uri)
        $HostProps.Add('ApiKey',$ApiKey)
        $HostObj = New-Object -TypeName psobject -Property $HostProps
        $HostObj.pstypenames[0] = 'OctoPrint.Host'

        [void]$Global:OctoHost.Add($HostObj)
        $HostObj

        Set-Content -Path $Global:OctoPSConfigPath  -Value (ConvertTo-Json -InputObject $Global:OctoHost )
    }

    end {
    }
}