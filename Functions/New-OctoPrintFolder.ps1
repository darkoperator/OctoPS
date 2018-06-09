function New-OctoPrintFolder {
    [CmdletBinding()]
    param (
        # Printer Host Id
        [Parameter(Mandatory=$false,
                   ParameterSetName = 'Index')]
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
        $RemotePath
    )

    begin {
        $UriPath = "/api/files/$($Location.ToLower())"
    }

    process
    {


        if ($Id.count -gt 0) {
            $PHosts = Get-OctoPrintHost -Id $Id
            foreach ($h in $PHosts) {

                $RestClient = New-Object RestSharp.RestClient
                $RestRequest = New-Object RestSharp.RestRequest
                $RestClient.BaseUrl =  "$($h.Uri)$($UriPath)"
                [void]$RestRequest.AddHeader('X-Api-Key',$h.ApiKey)
                $RestRequest.Method = [RestSharp.Method]::POST

                [void]$RestRequest.AddParameter("foldername",$FolderName)
                if ($RemotePath.Length -gt 0) {
                    [void]$RestRequest.AddParameter("path", "$($RemotePath -creplace '^[^\/]*\/', '')")
                }

                $Response = $RestClient.Execute($RestRequest)
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
        else {
            $FirstOctoHost = Get-OctoPrintHost | Select-Object -First 1
            $RestClient = New-Object RestSharp.RestClient
            $RestRequest = New-Object RestSharp.RestRequest
            $RestClient.BaseUrl =  "$($FirstOctoHost.Uri)$($UriPath)"
            [void]$RestRequest.AddHeader('X-Api-Key',$FirstOctoHost.ApiKey)
            $RestRequest.Method = [RestSharp.Method]::POST
            [void]$RestRequest.AddParameter("foldername",$FolderName)
            if ($RemotePath.Length -gt 0)
            {
                [void]$RestRequest.AddParameter("path", "$($RemotePath -creplace '^[^\/]*\/', '')")
            }

            $Response = $RestClient.Execute($RestRequest)
            $FileMeta = (ConvertFrom-Json $response.Content).Folder
            $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
            $FProps.Add('Name',$FileMeta.name)
            $FProps.Add('Origin',$FileMeta.origin)
            $FProps.Add('Path',$FileMeta.path)
            $FProps.Add('Reference',$FileMeta.refs)
            $FProps.Add('HostId',$FirstOctoHost.Id)
            $PPObj = New-Object -TypeName psobject -Property $FProps
            $PPObj.pstypenames[0] = 'OctoPrint.Folder'
            $PPObj


        }
    }
}
