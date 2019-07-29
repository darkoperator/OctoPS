function Select-OctoPSTool {
     <#
    .SYNOPSIS
        Select the default tool for a printer on a OctoPrint server.
    .DESCRIPTION
       Select the default tool for a printer on a OctoPrint server.
    .EXAMPLE
        PS C:\> Select-OctoPSTool -Tool tool1 -Id 1 -SkipCertificateCheck
        Set tool1 as the default tool on the OctoPrint server with Id 1
    .INPUTS
        Int32
    #>
    [CmdletBinding(DefaultParameterSetName = "Temp")]
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

        # Tool to make the default one.
        [Parameter(Mandatory = $false)]
        [ValidateSet('tool0', 'tool1', 'tool2', 'tool3', 'tool4')]
        [string]
        $Tool
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

            $Body.Add("command","select")
            $Body.Add("tool", $Tool.ToLower()) 

            
            $RestMethodParams.Add('Body',(ConvertTo-Json -InputObject $body))
            Invoke-RestMethod @RestMethodParams
        }
    }

    end {
    }
}