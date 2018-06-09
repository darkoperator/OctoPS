<#
.SYNOPSIS
    Delete a specified file or folder from a OctoPrint server.
.DESCRIPTION
    Deletes a specified file or folder from a OctoPrint server.
.EXAMPLE
    PS C:\> Get-OctoPrintItem -FileType model | Remove-OctoPrintFile -verbose
    Delete all model files from the first OctoPrint Server.
.INPUTS
    OctoPrint.File
    OctoPrint.Folder
#>
function Remove-OctoPrintItem {
    [CmdletBinding()]
    param (
        # Printer Host Id
        [Parameter(Mandatory=$false,
                   ParameterSetName = 'Index',
                   Position=0,
                   ValueFromPipelineByPropertyName = $true)]
        [Alias('HostId')]
        [int32[]]
        $Id = @(),

        # Location where file is at.
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Local',"SDCard")]
        [string]
        $Location = "Local",

        # Path of file to remove including name of the file.
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]
        $Path

    )

    begin {
        $RestMethodParams = @{
            'Method' =  "Delete"
        }
    }

    process {
        $UriPath = "/api/files/$($location.ToLower())/$($Path)"
        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPrintHost -Id $Id
            foreach ($h in $PHosts) {

                $RestMethodParams.Add('URI',"$($h.Uri)$($UriPath)")
                $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

                if ($Parameter)
                {
                    $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
                }
                Write-Verbose -Message "Deleting file at $($Location) named $($Path) from host with Id $($h.Id)"
                Invoke-RestMethod @RestMethodParams
            }
        } else {
            $FirstOctoHost = Get-OctoPrintHost | Select-Object -First 1
            $RestMethodParams.Add('URI',"$($FirstOctoHost.Uri)$($UriPath)")
            $RestMethodParams.Add('Headers', @{'X-Api-Key' = $FirstOctoHost.ApiKey})

            if ($Parameter)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }
            Write-Verbose -Message "Deleting file at $($Location) named $($Path) from host with Id $($FirstOctoHost.Id)"
            Invoke-RestMethod @RestMethodParams
        }
    }
    
    end {
    }
}