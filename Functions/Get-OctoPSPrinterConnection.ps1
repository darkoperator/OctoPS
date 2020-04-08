<#
.SYNOPSIS
    Get the current printer connection settings and state on a OctoPrint server.
.DESCRIPTION
    Get the current printer connection settings and state on a OctoPrint server.
.EXAMPLE
    PS C:\> Get-OctoPSPrinterConnection -SkipCertificateCheck


    Profile  : cr-10s
    State    : Operational
    Port     : VIRTUAL
    BoudRate :
    Options  : @{baudratePreference=115200; baudrates=System.Object[]; portPreference=VIRTUAL; ports=System.Object[]; printerProfilePreference=cr-10s; printerProfiles=System.Object[]}
    HostId   : 1
.INPUTS
        Int32
.OUTPUTS
    OctoPrint.ConnectionSettings
#>
function Get-OctoPSPrinterConnection {
    [CmdletBinding()]
    param (
     # OctoPrint Host  Id
        [Parameter(Mandatory = $False,
            Position = 0,
        ValueFromPipelineByPropertyName = $true)]

        [int32[]]
        $Id = @(),

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc.
        [Parameter(Mandatory = $false)]
        [switch]
        $SkipCertificateCheck
    )

    begin {

    }
    
    process {
        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPSHost -Id $Id
        }
        else {
            $PHosts = Get-OctoPSHost | Select-Object -First 1
        }
        foreach ($h in $PHosts) {
            $RestMethodParams = @{
                'Method'        = "Get"
            }
            $RestMethodParams.Add('URI',"$($h.Uri)/api/connection")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            $ConnectionSettings = (Invoke-RestMethod @RestMethodParams)

            $PPProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
            $PPProps.Add('Profile',$ConnectionSettings.current.printerProfile)
            $PPProps.Add('State',$ConnectionSettings.current.state)
            $PPProps.Add('Port',$ConnectionSettings.current.port)
            $PPProps.Add('BoudRate',$ConnectionSettings.current.baudrate)
            $PPProps.Add('Options',$ConnectionSettings.options)
            $PPProps.Add('HostId',$h.Id)
            $PPObj = New-Object -TypeName psobject -Property $PPProps
            $PPObj.pstypenames[0] = 'OctoPrint.ConnectionSettings'
            $PPObj
        }
    }

    end {
    }
}