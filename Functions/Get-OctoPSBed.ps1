function Get-OctoPSBed {
    <#
    .SYNOPSIS
        Get the bed temparature, target and offset for a given OctoPrint server.
    .DESCRIPTION
        Get the bed temparature, target and offset for a given OctoPrint server.
    .EXAMPLE
        PS C:\> Get-OctoPSBed -SkipCertificateCheck -Id 1


            Name        : bed
            Temperature : 20.43
            Target      : 0
            Offset      : 0
            HostId      : 1

        Get the temperature for the printer with Id 1. 
    .INPUTS
        Int32
    .OUTPUTS
        OctoPrint.BedInfo
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
        $RestMethodParams = @{
            'Method'        = "Get"
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
                $TProps.Add('HostId',$h.Id)
                $ToolObj = New-Object -TypeName psobject -Property $TProps
                $ToolObj.pstypenames[0] = 'OctoPrint.BedInfo'
                $ToolObj
            }
        }
    }

    end {
    }
}