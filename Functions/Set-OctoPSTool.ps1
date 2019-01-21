function Set-OctoPSTool {
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

        # Tool to issue command against. Defaults to tool0.
        [Parameter(Mandatory = $false)]
        [ValidateSet('tool0', 'tool1', 'tool2', 'tool3', 'tool4')]
        [string]
        $Tool = 'tool0',

        # Temperature to set as targt for the tool in Celcius.
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Temp')]
        [Int]
        $TargetTemp,

        # Temperature offset.
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Offset')]
        [int]
        $Offset,

        # Set the flowr ate percentage factor on the selected tool.
        [Parameter(Mandatory = $true,
            ParameterSetName = 'Flowrate')]
        [int]
        $FlowRate
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
            switch ($PSCmdlet.ParameterSetName) {
                'Temp'     { Write-Verbose -Message "Setting tool $($Tool.ToLower()) to temperature $($TargetTemp) Celcius."
                             $Body.Add("command","target")
                             $Body.Add("targets",@{"$($Tool.ToLower())" = $TargetTemp}) 
                           }
                'Offset'   { Write-Verbose -Message "Setting temperature offset of $($Offset) for tool $($Tool)."
                             $Body.Add('command', 'offset')
                             $Body.Add('Offsets', @{$Tool.ToLower() = $Offset})
                           }
                'Flowrate' { Write-Verbose -Message "Setting the flow rate to $($FlowRate)."
                             $Body.Add('command', 'flowrate')
                             $Body.Add('factor', $FlowRate)
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