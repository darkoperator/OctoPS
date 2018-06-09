function Get-OctoPrintFile {
    [CmdletBinding(DefaultParameterSetName = "All")]
    param (
        # Printer Host Id
        [Parameter(Mandatory=$false,
                   ParameterSetName = 'Index',
                   Position=0)]
        [Alias('HostId')]
        [int32[]]
        $Id = @(),

        # Recurse though subfolders.
        [Parameter(Mandatory = $false)]
        [switch]
        $Recurse,

        # Path to list files for
        [Parameter(Mandatory = $false,
            ParameterSetName = "Targeted")]
        [string]
        $Path,

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc.
        [Parameter(Mandatory = $false)]
        [switch]
        $SkipCertificateCheck,

        # Name of the file to get. Accepts wildcards.
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [SupportsWildcards()]
        [string]
        $Name
    )
    
    begin {
        $RestMethodParams = @{
            'Method'        = "Get"
        }

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
            $PHosts = Get-OctoPrintHost -Id $Id
            foreach ($h in $PHosts) {

                $RestMethodParams.Add('URI',"$($h.Uri)$($UriPath)")
                $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

                if ($Parameter)
                {
                    $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
                }

                (Invoke-RestMethod @RestMethodParams).files | Foreach-Object {
                    if ($_.type -eq "machinecode") {
                        if ($Name.Length -gt 0) {
                            if ($_.Name -like $Name) {
                                $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                                $FProps.Add('Name',$_.Name)
                                $FProps.Add('Date',[datetime]$_.date)
                                $FProps.Add('Origin',$_.origin)
                                $FProps.Add('Path',$_.path)
                                $FProps.Add('Type',$_.type)
                                $FProps.Add('Size',$_.size)
                                $FProps.Add('Hash',$_.hash)
                                $FProps.Add('Prints',$_.prints)
                                $FProps.Add('statistics',$_.statistics)
                                $FProps.Add('References',$_.refs)
                                $FProps.Add('HostId',$h.Id)
                                $PPObj = New-Object -TypeName psobject -Property $FProps
                                $PPObj.pstypenames[0] = 'OctoPrint.File'
                                $PPObj
                            }
                        } else {
                            $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                            $FProps.Add('Name',$_.Name)
                            $FProps.Add('Date',[datetime]$_.date)
                            $FProps.Add('Origin',$_.origin)
                            $FProps.Add('Path',$_.path)
                            $FProps.Add('Type',$_.type)
                            $FProps.Add('Size',$_.size)
                            $FProps.Add('Hash',$_.hash)
                            $FProps.Add('Prints',$_.prints)
                            $FProps.Add('statistics',$_.statistics)
                            $FProps.Add('References',$_.refs)
                            $FProps.Add('HostId',$h.Id)
                            $PPObj = New-Object -TypeName psobject -Property $FProps
                            $PPObj.pstypenames[0] = 'OctoPrint.File'
                            $PPObj
                        }
                    }
                }


            }
        } else {
            $FirstOctoHost = Get-OctoPrintHost | Select-Object -First 1
            $RestMethodParams.Add('URI',"$($FirstOctoHost.Uri)$($UriPath)")
            $RestMethodParams.Add('Headers', @{'X-Api-Key' = $FirstOctoHost.ApiKey})

            if ($Parameter)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            (Invoke-RestMethod @RestMethodParams).files | Foreach-Object {
                if ($_.type -eq "machinecode") {
                    if ($Name.Length -gt 0) {
                        if ($_.Name -like $Name) {
                            $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                            $FProps.Add('Name',$_.Name)
                            $FProps.Add('Date',[datetime]$_.date)
                            $FProps.Add('Origin',$_.origin)
                            $FProps.Add('Path',$_.path)
                            $FProps.Add('Type',$_.type)
                            $FProps.Add('Size',$_.size)
                            $FProps.Add('Hash',$_.hash)
                            $FProps.Add('Prints',$_.prints)
                            $FProps.Add('statistics',$_.statistics)
                            $FProps.Add('References',$_.refs)
                            $FProps.Add('HostId',$FirstOctoHost.Id)
                            $PPObj = New-Object -TypeName psobject -Property $FProps
                            $PPObj.pstypenames[0] = 'OctoPrint.File'
                            $PPObj
                        }
                    } else {
                        $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                        $FProps.Add('Name',$_.Name)
                        $FProps.Add('Date',[datetime]$_.date)
                        $FProps.Add('Origin',$_.origin)
                        $FProps.Add('Path',$_.path)
                        $FProps.Add('Type',$_.type)
                        $FProps.Add('Size',$_.size)
                        $FProps.Add('Hash',$_.hash)
                        $FProps.Add('Prints',$_.prints)
                        $FProps.Add('statistics',$_.statistics)
                        $FProps.Add('References',$_.refs)
                        $FProps.Add('HostId',$FirstOctoHost.Id)
                        $PPObj = New-Object -TypeName psobject -Property $FProps
                        $PPObj.pstypenames[0] = 'OctoPrint.File'
                        $PPObj
                    }
                }
            }

        }
    }

    end {
    }
}