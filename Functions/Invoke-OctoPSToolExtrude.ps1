function Invoke-OctoPSToolExtrude {
    <#
    .SYNOPSIS
        Extrude a given amount of material on the default tool for a printer on a OctoPrint server.
    .DESCRIPTION
        Extrude a given amount of material on the default tool for a printer on a OctoPrint server.
    .EXAMPLE
        PS C:\> Invoke-OctoPSToolExtrude -Id 1 -SkipCertificateCheck -Speed 100 -Amount 20
        Extrude 20mm of material at 100mm per minute. 
    .INPUTS
        Int32
        Int
    #>
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

        # Speed for extruding material in millimeters per minute.
        [Parameter(Mandatory = $false)]
        [Int]
        $Speed,

        # Ammount of material to extrude in millimeters, if a negative value is provide the extruder will retract.
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
            $PHosts = Get-OctoPSHost -Id $Id
        }
        else {
            $PHosts = Get-OctoPSHost | Select-Object -First 1
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