<#
.SYNOPSIS
    Retrieves the current state of the printer on a OctoPrint server.
.DESCRIPTION
    Retrieves the current state of the printer. Returned information includes:

    * Temperature information
    * SD state (if available)
    * General printer state

    Temperature information can also be made to include the printer’s temperature
    history by supplying the History parameter. The amount of data points to return
    here can be limited using the Limit parameter, has a default value of 1.
.EXAMPLE
    PS C:\> Get-OctoPSPrinterState -SkipCertificateCheck
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Get-OctoPSPrinterState {
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

        # Include temperature history of actions and temperatures.
        [Parameter(Mandatory = $false)]
        [switch]
        $History,

        # Number of entries from the history log to pull.
        [Parameter(Mandatory = $false)]
        [Int]
        $Limit = 1,

        # Exclude temeprature from hoistory.
        [Parameter(mandatory = $false)]
        [switch]
        $ExcludeTemperature,

         # Exclude state from hoistory.
         [Parameter(mandatory = $false)]
         [switch]
         $ExcludeState,

          # Exclude SD from hoistory.
        [Parameter(mandatory = $false)]
        [switch]
        $ExcludeSD
    )
    
    begin {
        $QueryPath = "/api/printer?"

        if ($History) {
            $QueryPath = $QueryPath + "history=true&limit=$($Limit)"
        } else {
            $QueryPath = $QueryPath + "history=false"
        }

        if ($ExcludeTemperature -or $ExcludeState -or $ExcludeSD) {
            $exclusionParam = @()
            if ($ExcludeTemperature) {$exclusionParam.Add('temperature')}
            if ($ExcludeState) {$exclusionParam.Add('state')}
            if ($ExcludeSD) {$exclusionParam.Add('sd')}
            $QueryPath = $QueryPath + "&exclude=$( $excludeParam -join "," )"
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
            $RestMethodParams = @{
                'Method'        = "Get"
            }

            $RestMethodParams.Add('URI',"$($h.Uri)$($QueryPath)")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            Try {
                $StateInfo = (Invoke-RestMethod @RestMethodParams)
                $tools = @()
                $PPProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                $PPProps.Add('SDCard',$StateInfo.sd.ready)
                $PPProps.Add('State',$StateInfo.state.text)
                $PPProps.Add('BedTemp',$StateInfo.temperature.bed)
                $StateInfo.temperature | ForEach-Object {
                    $Component = $_
                    $Component.psobject.properties | ForEach-Object {
                        if ($_.name -like "tool*") {
                            Write-Verbose $_.name
                            $tools += New-Object -TypeName psobject -Property @{"$($_.name)" = $Component."$($_.name)"}
                        }
                    }
                }
                $PPProps.Add('Tool',$tools)
                $PPProps.Add('HostId',$h.Id)
                $PPObj = New-Object -TypeName psobject -Property $PPProps
                $PPObj.pstypenames[0] = 'OctoPrint.PrinterState'
                $PPObj 
            } catch {
                if ($_.ErrorDetails -like "*not operational*") {
                    $PPProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                    $PPProps.Add('SDCard',"")
                    $PPProps.Add('State',"Not Operational")
                    $PPProps.Add('BedTemp',"")
                    $PPProps.Add('Tool',"")
                    $PPProps.Add('HostId',$h.Id)
                    $PPObj = New-Object -TypeName psobject -Property $PPProps
                    $PPObj.pstypenames[0] = 'OctoPrint.PrinterState'
                    $PPObj
                } else {
                    $_
                }
            }
        } 
    }

    end {
    }
}
