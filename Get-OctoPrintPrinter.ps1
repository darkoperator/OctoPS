function Get-OctoPrintPrinter {
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
        $SkipCertificateCheck,

        [Parameter( Mandatory = $false)]


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

                $RestMethodParams.Add('URI',"$($h.Uri)/api/printerprofiles")
                $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

                if ($Parameter)
                {
                    $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
                }

                (Invoke-RestMethod @RestMethodParams).profiles | Foreach-Object {
                    $_.PSObject.Properties | Foreach-Object {
                        $PPProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                        $PPProps.Add('Name',$_.Value.Name)
                        $PPProps.Add('Default',$_.Value.default)
                        $PPProps.Add('ProfileId',$_.Value.id)
                        $PPProps.Add('Model',$_.Value.model)
                        $PPProps.Add('HeatedBed',$_.Value.heatedBed)
                        $PPProps.Add('Volume',$_.Value.volume)
                        $PPProps.Add('Extruder',$_.Value.extruder)
                        $PPProps.Add('Current',$_.Value.current)
                        $PPProps.Add('Axes',$_.Value.axes)
                        $PPProps.Add('Color',$_.Value.color)
                        $PPProps.Add('HostId',$h.Id)
                        $PPObj = New-Object -TypeName psobject -Property $PPProps
                        $PPObj.pstypenames[0] = 'OctoPrint.PrinterProfile'
                        $PPObj
                    }
                }


            }
        } else {
            $FirstOctoHost = Get-OctoPrintHost | Select-Object -First 1
            $RestMethodParams.Add('URI',"$($FirstOctoHost.Uri)/api/printerprofiles")
            $RestMethodParams.Add('Headers', @{'X-Api-Key' = $FirstOctoHost.ApiKey})

            if ($Parameter)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            (Invoke-RestMethod @RestMethodParams).profiles | Foreach-Object {
                $_.PSObject.Properties | Foreach-Object {
                    $PPProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                    $PPProps.Add('Name',$_.Value.Name)
                    $PPProps.Add('Default',$_.Value.default)
                    $PPProps.Add('ProfileId',$_.Value.id)
                    $PPProps.Add('Model',$_.Value.model)
                    $PPProps.Add('HeatedBed',$_.Value.heatedBed)
                    $PPProps.Add('Volume',$_.Value.volume)
                    $PPProps.Add('Extruder',$_.Value.extruder)
                    $PPProps.Add('Current',$_.Value.current)
                    $PPProps.Add('Axes',$_.Value.axes)
                    $PPProps.Add('Color',$_.Value.color)
                    $PPProps.Add('HostId',$FirstOctoHost.Id)
                    $PPObj = New-Object -TypeName psobject -Property $PPProps
                    $PPObj.pstypenames[0] = 'OctoPrint.PrinterProfile'
                    $PPObj
                }
            }
        }
    }

    end {
    }
}