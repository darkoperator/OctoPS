function Invoke-OctoPSHomeAxis {
    <#
    .SYNOPSIS
        Home all axis of a printer connected to a OctoPrint server.
    .DESCRIPTION
        Home all axis of a printer connected to a OctoPrint server.
    .EXAMPLE
        PS C:\> <Invoke-OctoPSHomeAxis -SkipCertificateCheck -Id 1
        Home all axis (X, Y and X)
    .INPUTS
        Int32
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
        $SkipCertificateCheck,

        # Axis to home. Values can be X, Y or Z, Default value is all 3 axes.
        [Parameter(Mandatory = $false)]
        [ValidateSet('X', 'Y', 'Z')]
        [string[]]
        $Axis = @('X', 'Y', 'Z')
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
            $RestMethodParams.Add('URI',"$($h.Uri)/api/printer/printhead")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})
            $RestMethodParams.Add('ContentType','application/json')

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }
            $Body = New-Object System.Collections.Specialized.OrderedDictionary
            
            $Body.Add("command","home")
            $Body.Add("axes", $Axis.ToLower())            
            $RestMethodParams.Add('Body',(ConvertTo-Json -InputObject $body))
            Invoke-RestMethod @RestMethodParams | Out-Null
        }
    }
    
    end {
    }
}