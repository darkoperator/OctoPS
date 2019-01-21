function Get-OctoPSBed {
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
            $PHosts = Get-OctoPrintHost -Id $Id
        }
        else {
            $PHosts = Get-OctoPrintHost | Select-Object -First 1
        }
        foreach ($h in $PHosts) {

            $RestMethodParams.Add('URI',"$($h.Uri)/api/printer/bed?history=false")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }
            
            Invoke-RestMethod @RestMethodParams| Foreach-Object {
                $TProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                $toolname = ($_.PSObject.Properties).name
                $TProps.Add('Name',$toolname)
                $TProps.Add("Temperature", $_."$($toolname)".actual)
                $TProps.Add("Target", $_."$($toolname)".target)
                $TProps.Add("Offset", $_."$($toolname)".offset)
                $ToolObj = New-Object -TypeName psobject -Property $TProps
                $ToolObj
            }
        }
    }

    end {
    }
}