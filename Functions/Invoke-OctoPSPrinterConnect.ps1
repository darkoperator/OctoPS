<#
.SYNOPSIS
    Issue to OctoPrint a command to connect the printer.
.DESCRIPTION
    Issue to OctoPrint a command to connect the printer.
.EXAMPLE
    PS C:\> Get-OctoPSPrinterConnection

    Profile  : _default
    State    : Closed
    Port     :
    BoudRate :
    Options  : @{baudratePreference=115200; baudrates=System.Object[]; portPreference=VIRTUAL; ports=System.Object[]; printerProfilePreference=cr-10s;
            printerProfiles=System.Object[]}
    HostId   : 1

    PS C:\>  Invoke-OctoPSPrinterConnect

    PS C:\>  Get-OctoPSPrinterConnection

    Profile  : cr-10s
    State    : Operational
    Port     : VIRTUAL
    BoudRate :
    Options  : @{baudratePreference=115200; baudrates=System.Object[]; portPreference=VIRTUAL; ports=System.Object[]; printerProfilePreference=cr-10s;
            printerProfiles=System.Object[]}
    HostId   : 1
#>
function Invoke-OctoPSPrinterConnect {
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

        # Specific port to connect to. If not set the current portPreference will be used, or if no preference is available auto detection will be attempted.
        [Parameter(Mandatory = $false)]
        [string]
        $Port,

        # Specific baudrate to connect with. If not set the current baudratePreference will be used, or if no preference is available auto detection will be attempted.
        [Parameter(Mandatory = $false)]
        [Int]
        $BaudRate,

        # Specific printer profile to use for connection. If not set the current default printer profile will be used.
        [Parameter(Mandatory = $false)]
        [string]
        $PrinterProfile,

        # Whether to save the request’s port and baudrate settings as new preferences.
        [Parameter(Mandatory = $false)]
        [switch]
        $Save,

        # Whether to automatically connect to the printer on OctoPrint’s startup in the future. If not set no changes will be made to the current configuration.
        [Parameter(Mandatory = $false)]
        [Switch]
        $AutoConnect
    )

    begin {
        $commandBody =  @{"command" = "connect"}
        if ($Port -ne "") {
            $Port.Lenght
            Write-Verbose -Message "Connecting to port $($Port)"
            $commandBody.Add('port', $Port)
        }

        if ($BaudRate -ne 0) {
            Write-Verbose -Message "Connecting using the baud rate of $($BaudRate)"
            $commandBody.Add('baudrate', $BaudRate)
        }

        if ( $PrinterProfile -ne "" ) {
            Write-Verbose -Message "Connecting using the profile $( $PrinterProfile )"
            $commandBody.Add('printerProfile', $PrinterProfile)
        }

        if ($Save) {
            Write-Verbose -Message "Saving settings after connection.)"
            $commandBody.Add('save', $true)
        }

        if ($AutoConnect) {
            Write-Verbose -Message "Setting autoconnect.)"
            $commandBody.Add('autoconnect', $true)
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
            $PHosts = Get-OctoPSHost -Id $Id
        }
        else {
            $PHosts = Get-OctoPSHost | Select-Object -First 1
        }
        foreach ($h in $PHosts) {

            $RestMethodParams.Add('URI',"$($h.Uri)/api/connection")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})
            
            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            Invoke-RestMethod @RestMethodParams | Out-Null
        }
    }

    end {
    }
}