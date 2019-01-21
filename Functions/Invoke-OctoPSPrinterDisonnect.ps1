<#
.SYNOPSIS
    Issue to OctoPrint a command to disconnect the printer.
.DESCRIPTION
    Issue to OctoPrint a command to disconnect the printer.
.EXAMPLE
    PS C:\>  Invoke-OctoPSPrinterDisconnect

    PS C:\>  Get-OctoPSPrinterConnection


Profile  : _default
State    : Closed
Port     :
BoudRate :
Options  : @{baudratePreference=115200; baudrates=System.Object[]; portPreference=VIRTUAL; ports=System.Object[]; printerProfilePreference=cr-10s;
           printerProfiles=System.Object[]}
HostId   : 1
#>
function Invoke-OctoPSPrinterDisconnect {
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
        $commandBody =  @{"command" = "disconnect"}
        if ($Port -ne "") {
            $Port.Lenght
            Write-Verbose -Message "Connecting to port $($Port)"
            $commandBody.Add('port', $Port)
        }

        $Body = ConvertTo-Json -InputObject $commandBody
        $RestMethodParams = @{
            'Method'        = "Post"
            'ContentType'   = 'application/json'
            'Body'          = $Body
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

            $RestMethodParams.Add('URI',"$($h.Uri)/api/connection")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            Invoke-RestMethod @RestMethodParams
        }
    }

    end {
    }
}