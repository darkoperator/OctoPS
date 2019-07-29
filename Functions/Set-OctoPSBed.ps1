function Set-OctoPSBed {
    <#
    .SYNOPSIS
        Set the bed temparature for a printer on a OctoPrint server.
    .DESCRIPTION
        Set the bed temparature for a printer on a OctoPrint server.
    .EXAMPLE
        PS C:\> Set-OctoPSBed -SkipCertificateCheck -TargetTemp 60
        Set the temperature of the bed to 60 celcius.
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

        # Temperature to set as targt for the tool in Celcius.
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Temp')]
        [Int]
        $TargetTemp,

        # Temperature offset.
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Offset')]
        [int]
        $Offset
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

            $RestMethodParams.Add('URI',"$($h.Uri)/api/printer/bed")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})
            $RestMethodParams.Add('ContentType','application/json')

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }
            $Body = New-Object System.Collections.Specialized.OrderedDictionary
            switch ($PSCmdlet.ParameterSetName) {
                'Temp'     { Write-Verbose -Message "Setting bed to temperature $($TargetTemp) Celcius."
                             $Body.Add("command", "target")
                             $Body.Add("target", $TargetTemp) 
                           }
                'Offset'   { Write-Verbose -Message "Setting temperature offset of $($Offset) for the bed."
                             $Body.Add('command', 'offset')
                             $Body.Add('offset', $Offset)
                           }
                Default {}
            }  
            $RestMethodParams.Add('Body',(ConvertTo-Json -InputObject $body))
            Invoke-RestMethod @RestMethodParams
        }
    }

    end {
    }
}