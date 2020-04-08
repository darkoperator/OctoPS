function Get-OctoPSTool {
    <#
    .SYNOPSIS
        Get information on the tools of a prunter connected to a OctoPrint server.
    .DESCRIPTION
        Get information on the tools of a prunter connected to a OctoPrint server..
    .EXAMPLE
        PS C:\> Get-OctoPSTool -SkipCertificateCheck


        Name        : tool0
        Temperature : 19.49
        Target      : 0
        Offset      : 0
        HostId      : 1

    .INPUTS
        Int32
    .OUTPUTS
        OctoPrint.PrinterProfile
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
        }
        else {
            $PHosts = Get-OctoPSHost | Select-Object -First 1
        }
        foreach ($h in $PHosts) {
            $RestMethodParams = @{
                'Method'        = "Get"
            }
            $RestMethodParams.Add('URI',"$($h.Uri)/api/printer/tool?history=false")
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
                $ToolObj.pstypenames[0] = 'OctoPrint.Tool'
                $ToolObj
            }
        }
    }

    end {
    }
}