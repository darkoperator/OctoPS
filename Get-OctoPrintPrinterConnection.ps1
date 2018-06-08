<#
.SYNOPSIS
    Get the current printer connection settings and state.
.DESCRIPTION
    Get the current printer connection settings and state.
.EXAMPLE
    PS C:\> Get-OctoPrintPrinterConnection


    Profile  : cr-10s
    State    : Operational
    Port     : VIRTUAL
    BoudRate :
    Options  : @{baudratePreference=115200; baudrates=System.Object[]; portPreference=VIRTUAL; ports=System.Object[]; printerProfilePreference=cr-10s; printerProfiles=System.Object[]}
    HostId   : 1
#>
function Get-OctoPrintPrinterConnection {
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
        $RestMethodParams = @{
            'Method'        = "Get"
        }

    }
    
    process {
        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPrintHost -Id $Id
            foreach ($h in $PHosts) {

                $RestMethodParams.Add('URI',"$($h.Uri)/api/connection")
                $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

                if ($Parameter)
                {
                    $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
                }

                $ConnectionSettings = (Invoke-RestMethod @RestMethodParams)

                $PPProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                $PPProps.Add('Profile',$ConnectionSettings.current.printerProfile)
                $PPProps.Add('State',$ConnectionSettings.current.state)
                $PPProps.Add('Port',$ConnectionSettings.current.port)
                $PPProps.Add('BoudRate',$ConnectionSettings.current.boudrate)
                $PPProps.Add('Options',$ConnectionSettings.options)
                $PPProps.Add('HostId',$h.Id)
                $PPObj = New-Object -TypeName psobject -Property $PPProps
                $PPObj.pstypenames[0] = 'OctoPrint.ConnectionSettings'
                $PPObj




            }
        } else {
            $FirstOctoHost = Get-OctoPrintHost | Select-Object -First 1
            $RestMethodParams.Add('URI',"$($FirstOctoHost.Uri)/api/connection")
            $RestMethodParams.Add('Headers', @{'X-Api-Key' = $FirstOctoHost.ApiKey})

            if ($Parameter)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            $ConnectionSettings = (Invoke-RestMethod @RestMethodParams)

            $PPProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
            $PPProps.Add('Profile',$ConnectionSettings.current.printerProfile)
            $PPProps.Add('State',$ConnectionSettings.current.state)
            $PPProps.Add('Port',$ConnectionSettings.current.port)
            $PPProps.Add('BoudRate',$ConnectionSettings.current.boudrate)
            $PPProps.Add('Options',$ConnectionSettings.options)
            $PPProps.Add('HostId',$FirstOctoHost.Id)
            $PPObj = New-Object -TypeName psobject -Property $PPProps
            $PPObj.pstypenames[0] = 'OctoPrint.ConnectionSettings'
            $PPObj
        }
    }

    end {
    }
}