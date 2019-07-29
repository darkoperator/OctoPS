<#
.SYNOPSIS
    Get a list of files and their info from a OctoPrint Server.
.DESCRIPTION
    Get a list of files and their info from a OctoPrint Server.
.EXAMPLE
    PS C:\> Get-OctoPSFile -FileType model -SkipCertificateCheck


        Name       : Fang_CR10_Short_40mm_Space.stl
        Date       : 1/1/01 12:02:32 AM
        Origin     : local
        Path       : Fang_CR10_Short_40mm_Space.stl
        Type       : model
        Size       : 1872084
        Hash       : 4420b2437bf986feebd37437581e2b341a675c0e
        Prints     :
        statistics :
        References : @{download=http://192.168.1.237/downloads/files/local/Fang_CR10_Short_40mm_Space.stl; resource=http://192.168.1.237/api/files/local/Fang_CR10_Short_40mm_Space.stl}
        HostId     : 1

    Pull only model files from the server.
.EXAMPLE
    PS C:\> Get-OctoPSFile -SkipCertificateCheck -FileType MachineCode


        Name       : 3DBenchy.gcode
        Date       : 1/1/01 12:02:36 AM
        Location   : local
        Path       : 3DBenchy.gcode
        Type       : machinecode
        Size       : 3889019
        Hash       : c7821d986cef37a82e2c4c8cad5c96e626643d5f
        Prints     : @{failure=1; last=; success=0}
        statistics : @{averagePrintTime=; lastPrintTime=}
        References : @{download=https://192.168.1.237/downloads/files/local/3DBenchy.gcode; resource=https://192.168.1.237/api/files/local/3DBenchy.gcode}
        HostId     : 1

        Pull only MachineCode files from the server.

.EXAMPLE
    PS C:\> Get-OctoPSFile -Id 1 -FileType MachineCode -SkipCertificateCheck -Name *xyz*

    Find all gcode files with xyz in the name. 
.INPUTS
    System.IO.FileInfo
.OUTPUTS
    OctoPrint.File
#>
function Get-OctoPSFile {
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

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc.
        [Parameter(Mandatory = $false)]
        [switch]
        $SkipCertificateCheck,

        # Name of the file to get. Accepts wildcards.
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [SupportsWildcards()]
        [string]
        $Name,

        # Type of file to list. STL = Model, GCode = MachineCode.
        [Parameter(Mandatory = $false)]
        [ValidateSet('MachineCode','Model')]
        [string[]]
        $FileType = @('machinecode','model'),

        # Location of the files.
        [Parameter(Mandatory = $false)]
        [ValidateSet('Local',"SDCard")]
        [string]
        $Location = "Local"
    )

    begin {
        $RestMethodParams = @{
            'Method'        = "Get"
        }

        $UriPath = "/api/files/$($Location.ToLower())"

        if ($Recurse) {
            write-verbose -Message "Performing a recursive listing."
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
            foreach ($h in $PHosts) {

                $RestMethodParams.Add('URI',"$($h.Uri)$($UriPath)")
                $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

                if ($SkipCertificateCheck)
                {
                    $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
                }

                (Invoke-RestMethod @RestMethodParams).files | Foreach-Object {
                    if ($_.type -in $FileType) {
                        if ($Name.Length -gt 0) {
                            if ($_.Name -like $Name) {
                                $FProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                                $FProps.Add('Name',$_.Name)
                                $FProps.Add('Date',[datetime]$_.date)
                                $FProps.Add('Location',$_.origin)
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
                            $FProps.Add('Location',$_.origin)
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

        }
    }

    end {
    }
}