function Get-OctoPSVersion {
    <#
    .SYNOPSIS
        Get a given OctoPrint server version information.
    .DESCRIPTION
        Get a given OctoPrint server version information.
    .EXAMPLE
        PS C:\> Get-OctoPSVersion -SkipCertificateCheck

        api server text
        --- ------ ----
        0.1 1.3.11 OctoPrint 1.3.11

    .INPUTS
        Int32
    .OUTPUTS
        OctoPrint.VersionInfo'
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
    }
    
    process {
        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPSHost -Id $Id
        } else {
            $PHosts = Get-OctoPSHost 
        }
        foreach ($h in $PHosts) {
            $RestMethodParams = @{
                'Method'        = "Get"
            }
            $RestMethodParams.Add('URI',"$($h.Uri)/api/version")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            $versionInfo = Invoke-RestMethod @RestMethodParams
            $versionInfo.pstypenames[0] = 'OctoPrint.VersionInfo'
            $versionInfo
        }

    }
    
    end {
    }
}