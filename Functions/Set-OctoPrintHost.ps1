function Set-OctoPrintHost {
    [CmdletBinding(DefaultParameterSetName = 'New')]
    param (
        # Friendly name for OctoPi Server
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'New')]
        [string]
        $Name,

        # URI
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