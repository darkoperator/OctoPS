<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
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
        $RemotePath
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
            $PHosts = Get-OctoPrintHost -Id $Id
        }
        else {
            $PHosts = Get-OctoPrintHost | Select-Object -First 1
        }
        foreach ($h in $PHosts) {

            $RestClient = New-Object RestSharp.RestClient
            $RestRequest = New-Object RestSharp.RestRequest
            $RestClient.BaseUrl =  "$($h.Uri)$($UriPath)"
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
            $FileMeta = ($Response[1].Content).files."$($Location)"
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
