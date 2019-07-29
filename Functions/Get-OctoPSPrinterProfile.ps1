function Get-OctoPSPrinterProfile {
    <#
    .SYNOPSIS
        Get the current printer connection settings and state on a OctoPrint server.
    .DESCRIPTION
        Get the current printer connection settings and state on a OctoPrint server.
    .EXAMPLE
        PS C:\> Get-OctoPSJob -SkipCertificateCheck -Id 1     


            File          : Concealed_Cuff_Key.gcode
            Completion    : 100%
            FilePosition  : 744661
            PrintTime     : 00:14:03
            PrintTimeLeft : 00:00:00
            Progress      : 
            Target        : @{AveragePrintTime=843.760487348773; EstimatedPrintTime=872.828690189309; Filament=; File=; LastPrintTIme=843.760487348773}
            State         : Operational
            HostId        : 1

        Get the printer connection settings. 
    .INPUTS
        Int32
    .OUTPUTS
        OctoPrint.PrinterProfile
    #>
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
            $PHosts = Get-OctoPSHost -Id $Id
        }
        else {
            $PHosts = Get-OctoPSHost | Select-Object -First 1
        }
        foreach ($h in $PHosts) {

            $RestMethodParams.Add('URI',"$($h.Uri)/api/printerprofiles")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

            if ($SkipCertificateCheck)
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
    }

    end {
    }
}