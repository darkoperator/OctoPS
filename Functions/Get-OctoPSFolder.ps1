<#
.SYNOPSIS
    Get name and information on folders on a OctoPrint server.
.DESCRIPTION
    Get name and information on folders on a OctoPrint server.
.EXAMPLE
    PS C:\> Get-OctoPSFolder -Id 1 -SkipCertificateCheck -Recurse
    List all folders and subfolders on a OctoPrint server.
.INPUTS
    OctoPrint.Host'
.OUTPUTS
    OctoPrint.Folder
#>
function Get-OctoPSFolder {
    [CmdletBinding(DefaultParameterSetName = "All")]
    param (
        # Printer Host Id
        [Parameter(Mandatory=$false,
                   ParameterSetName = 'Index',
                   Position=0,
                   ValueFromPipelineByPropertyName = $true)]
        [Alias('HostId')]
        [int32[]]
        $Id = @(),

        # Recurse though subfolders.
        [Parameter(Mandatory = $false)]
        [switch]
        $Recurse,

        # Path to list folders for
        [Parameter(Mandatory = $false,
            ParameterSetName = "Targeted",
            ValueFromPipelineByPropertyName = $true)]
        [string]
        $Path,

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc.
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [switch]
        $SkipCertificateCheck,

        # Name of the folder to get. Accepts wildcards.
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [SupportsWildcards()]
        [string]
        $Name
    )
    
    begin {

        switch ($PSCmdlet.ParameterSetName) {
            "All"      { $UriPath = "/api/files" }
            "Targeted" { $UriPath = "/api/files/$($Path -creplace '^[^\/]*\/', '')" }
            Default { $UriPath = "/api/files" }
        }

        if ($Recurse) {
            $UriPath = $UriPath + "?recursive=true"
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
            $RestMethodParams = @{
                'Method'        = "Get"
            }
            $RestMethodParams.Add('URI',"$($h.Uri)$($UriPath)")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }
            (Invoke-RestMethod @RestMethodParams).files | Foreach-Object {
                if ($_.type -eq "folder") {

                    if ($Name.Length -gt 0) {
                        if ($_.Name -like $Name) {
                            $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                            $FProps.Add('Name',$_.name)
                            $FProps.Add('Origin',$_.origin)
                            $FProps.Add('Path',$_.path)
                            $FProps.Add('Type',$_.type)
                            $FProps.Add('References',$_.refs)
                            $FProps.Add('HostId',$h.Id)
                            $PPObj = New-Object -TypeName psobject -Property $FProps
                            $PPObj.pstypenames[0] = 'OctoPrint.Folder'
                            $PPObj
                        }
                    } else {
                        $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                        $FProps.Add('Name',$_.name)
                        $FProps.Add('Origin',$_.origin)
                        $FProps.Add('Path',$_.path)
                        $FProps.Add('Type',$_.type)
                        $FProps.Add('References',$_.refs)
                        $FProps.Add('HostId',$h.Id)
                        $PPObj = New-Object -TypeName psobject -Property $FProps
                        $PPObj.pstypenames[0] = 'OctoPrint.Folder'
                        $PPObj
                    }
                }
            }


        }
    }

    end {
    }
}