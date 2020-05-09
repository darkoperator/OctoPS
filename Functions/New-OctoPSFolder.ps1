function New-OctoPSFolder {
    <#
    .SYNOPSIS
        Create a new folder either on local storage on a OctoPrint server or the SDcard of a printer.
    .DESCRIPTION
        Create a new folder either on local storage on a OctoPrint server or the SDcard of a printer.
    .EXAMPLE
        PS C:\> New-OctoPSFolder -Id 1 -FolderName calibration -Location Local -RemotePath / -SkipCertificateCheck
        Create a new folder called calibration on the root of the local OctoPrint storage. 
    .INPUTS
        Int32
        Sctring
    .OUTPUTS
        OctoPrint.Folder
    .NOTES
        Saving to SDCard is very slow due to the nature of the serial connection between OctoPrint and most printers. 
    #>
    [CmdletBinding()]
    param (
        # Printer Host Id
        [Parameter(Mandatory=$false,
                   ParameterSetName = 'Index',
                   ValueFromPipelineByPropertyName = $true)]
        [Alias('HostId')]
        [int32[]]
        $Id = @(),

        # Name of folder to create on remote host..
        [Parameter(Mandatory = $true,
            Position = 0)]
        [string]
        $FolderName,

        # Location to place file.
        [Parameter(Mandatory = $false)]
        [ValidateSet('Local',"SDCard")]
        [string]
        $Location = "Local",

        # The path within the location to create the folder
        [Parameter(Mandatory = $false)]
        [string]
        $RemotePath,

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc.
        [Parameter(Mandatory = $false)]
        [switch]
        $SkipCertificateCheck
    )

    begin {
        $UriPath = "/api/files/$($Location.ToLower())"
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
        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPSHost -Id $Id
        }
        else {
            $PHosts = Get-OctoPSHost | Select-Object -First 1
        }
        foreach ($h in $PHosts) {

            $RestClient = New-Object RestSharp.RestClient

            if ($SkipCertificateCheck) {
                $RestClient.RemoteCertificateValidationCallback = [SSLHandler]::GetSSLHandler()
            }
            $RestRequest = New-Object RestSharp.RestRequest
            $RestClient.BaseUrl =  "$($h.Uri)$($UriPath)"
            [void]$RestRequest.AddHeader('X-Api-Key',$h.ApiKey)
            $RestRequest.Method = [RestSharp.Method]::POST

            [void]$RestRequest.AddParameter("foldername",$FolderName)
            if ($RemotePath.Length -gt 0) {
                [void]$RestRequest.AddParameter("path", "$($RemotePath -creplace '^[^\/]*\/', '')")
            }

            $Response = $RestClient.Execute($RestRequest)
            if ($Response.ResponseStatus -eq "Error") {
                Throw $Response.ErrorMessage
            }
            $FileMeta = (ConvertFrom-Json $response.Content).Folder
            $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
            $FProps.Add('Name',$FileMeta.name)
            $FProps.Add('Origin',$FileMeta.origin)
            $FProps.Add('Path',$FileMeta.path)
            $FProps.Add('Reference',$FileMeta.refs)
            $FProps.Add('HostId',$h.Id)
            $PPObj = New-Object -TypeName psobject -Property $FProps
            $PPObj.pstypenames[0] = 'OctoPrint.Folder'
            $PPObj

        }
    }
}
