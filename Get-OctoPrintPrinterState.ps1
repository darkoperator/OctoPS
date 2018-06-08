<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Retrieves the current state of the printer. Returned information includes:

    * Temperature information
    * SD state (if available)
    * General printer state

    Temperature information can also be made to include the printer’s temperature
    history by supplying the History parameter. The amount of data points to return
    here can be limited using the Limit parameter, has a default value of 1.
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Get-OctoPrintPrinterState {
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
        $RestMethodParams = @{
            'Method'        = "Get"
        }

    }

    process {
        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPrintHost -Id $Id
            foreach ($h in $PHosts) {
                $RestMethodParams.Add('URI',"$($h.Uri)$($QueryPath)")
                $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

                if ($Parameter)
                {
                    $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
                }

                Invoke-RestMethod @RestMethodParams

            }
        } else {
            $FirstOctoHost = Get-OctoPrintHost | Select-Object -First 1
            $RestMethodParams.Add('URI',"$($FirstOctoHost.Uri)$($QueryPath)")
            $RestMethodParams.Add('Headers', @{'X-Api-Key' = $FirstOctoHost.ApiKey})

            if ($Parameter)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            Invoke-RestMethod @RestMethodParams
        }
    }

    end {
    }
}