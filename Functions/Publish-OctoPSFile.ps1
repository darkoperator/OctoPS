<#
.SYNOPSIS
    Upload a file to a specified location on a OctoPrint server.
.DESCRIPTION
    Upload a file to a specified location on a OctoPrint server.
.EXAMPLE
    PS C:\> Publish-OctoPSFile -Id 1 -Path '/Users/carlos/Desktop/xyzcube.gcode' -Select -Location Local -RemotePath / -SkipCertificateCheck
    Upload and select a file for printing to the root of the local storage.
.INPUTS
    Int32
    String
.OUTPUTS
    OctoPrint.File
.NOTES
    Saving to SDCard is very slow due to the nature of the serial connection between OctoPrint and most printers. 
#>
function Publish-OctoPSFile {
    [CmdletBinding()]
    param (
        # Printer Host Id
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [Alias("HostId")]
        [int32[]]
        $Id = @(),

        # File to publish to OctoPrint server.
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $True)]
        [ValidateScript({Test-Path -Path $_})]
        [Alias('FullName')]
        [string]
        $Path,

        # Select file after upload.
        [Parameter(Mandatory =  $false)]
        [switch]
        $Select,

        # Print after upload
        [Parameter(Mandatory = $false)]
        [switch]
        $Print,

        # Location to place file.
        [Parameter(Mandatory = $false)]
        [ValidateSet('Local',"SDCard")]
        [string]
        $Location = "Local",

        # The path within the location to upload the file
        [Parameter(Mandatory = $false)]
        [string]
        $RemotePath,

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc.
        [Parameter(Mandatory = $false)]
        [switch]
        $SkipCertificateCheck
    )

    begin {
        $code = @"
public class SSLHandler
{
    public static System.Net.Security.RemoteCertificateValidationCallback GetSSLHandler()
    {

        return new System.Net.Security.RemoteCertificateValidationCallback((sender, certificate, chain, policyErrors) => { return true; });
    }

}
"@

    
    Add-Type -TypeDefinition $code
    }

    process
    {
        $fileinfo = Get-ItemProperty -Path $Path
        $FilePath = $fileinfo.FullName
        $UriPath = "/api/files/$($Location.ToLower())"

        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPSHost -Id $Id
        }
        else {
            $PHosts = Get-OctoPSHost | Select-Object -First 1
        }
        foreach ($h in $PHosts) {

            $RestClient = New-Object RestSharp.RestClient
            $RestRequest = New-Object RestSharp.RestRequest
            $RestClient.BaseUrl =  "$($h.Uri)$($UriPath)"

            if ($SkipCertificateCheck) {
                $RestClient.RemoteCertificateValidationCallback = [SSLHandler]::GetSSLHandler()
            }

            [void]$RestRequest.AddHeader('X-Api-Key',$h.ApiKey)
            $RestRequest.Method = [RestSharp.Method]::POST
            [void]$RestRequest.AddFile('file',$FilePath, 'application/octet-stream')
            Write-Verbose -Message "Uploading file $($Path)"
            if ($Select) {
                Write-Verbose -Message "File will be selected after upload."
                [void]$RestRequest.AddParameter("select", "true")
            }

            if ($Print) {
                Write-Verbose -Message "File will be printed after upload."
                [void]$RestRequest.AddParameter("print", "true")
            }

            if ($RemotePath.Length -gt 0) {
                Write-Verbose -Message "Uploading to path $($RemotePath)"
                [void]$RestRequest.AddParameter("path", "$($RemotePath -creplace '^[^\/]*\/', '')")
            }

            $Response = $RestClient.Execute($RestRequest)

            if ($Response.ResponseStatus -eq "Error") {
                Throw $Response.ErrorMessage
            }
            $ResponseContent = ConvertFrom-Json $resposnse[0].Content
            $FileMeta = $ResponseContent.files."$($Location)"
            $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
            $FProps.Add('Name',$FileMeta.name)
            $FProps.Add('Origin',$FileMeta.origin)
            $FProps.Add('Path',$FileMeta.path)
            $FProps.Add('Reference',$FileMeta.refs)
            $FProps.Add('HostId',$h.Id)
            $PPObj = New-Object -TypeName psobject -Property $FProps
            $PPObj.pstypenames[0] = 'OctoPrint.File'
            $PPObj

        }
    }
}
