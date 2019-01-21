function Invoke-OctoPSToolExtrude {
    [CmdletBinding()]
    param (
     # OctoPrint Host Id
        [Parameter(Mandatory = $False,
            Position = 0,
        ValueFromPipelineByPropertyName = $true)]
        [int32[]]
        $Id = @(),

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc.
        [Parameter(Mandatory = $false)]
        [switch]
        $SkipCertificateCheck,

        # Speed for extruding material.
        [Parameter(Mandatory = $false)]
        [Int]
        $Speed,

        # Ammount of material to extrude in MiliMeters, if a negative value is provide the extruder will retract.
        [Parameter(Mandatory = $true)]
        [int]
        $Amount
    )
    
    begin {
        $RestMethodParams = @{
            'Method'        = "Post"
        }

    }
    
    process {
        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPrintHost -Id $Id
        }
        else {
            $PHosts = Get-OctoPrintHost | Select-Object -First 1
        }
        foreach ($h in $PHosts) {

            $RestMethodParams.Add('URI',"$($h.Uri)/api/printer/tool")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})
            $RestMethodParams.Add('ContentType','application/json')

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }
            $Body = New-Object System.Collections.Specialized.OrderedDictionary
            Write-Verbose -Message "Extruding $($Amount)mm on default tool."
            
            $Body.Add("command","extrude")
            $Body.Add("amount", $Amount)
            if ($Speed -gt 0) {
                $Body.Add('speed', $Speed)
            } 
           
            
            $RestMethodParams.Add('Body',(ConvertTo-Json -InputObject $body))
            Invoke-RestMethod @RestMethodParams
        }
    }

    end {
    }
}