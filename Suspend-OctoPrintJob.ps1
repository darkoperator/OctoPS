function Suspend-OctoPrintJob {
    [CmdletBinding(DefaultParameterSetName = "All")]
    param (
        # Printer Host Id
        [Parameter(Mandatory=$false,
                   ParameterSetName = 'Index')]
        [int32[]]
        $Id = @(),

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc.
        [Parameter(Mandatory = $false)]
        [switch]
        $SkipCertificateCheck
    )
    
    begin {
        $commandBody = ConvertTo-Json -InputObject @{"command" = "pause"
                                                     "action" = "pause"}
        $RestMethodParams = @{
            'Method'        = "Post"
            'ContentType'   = 'application/json'
            'Body'          = $commandBody
        }

    }

    process {
        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPrintHost -Id $Id
            foreach ($h in $PHosts) {

                $RestMethodParams.Add('URI',"$($h.Uri)/api/job")
                $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

                if ($Parameter)
                {
                    $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
                }

                Invoke-RestMethod @RestMethodParams


            }
        } else {
            $FirstOctoHost = Get-OctoPrintHost | Select-Object -First 1
            $RestMethodParams.Add('URI',"$($FirstOctoHost.Uri)/api/job")
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