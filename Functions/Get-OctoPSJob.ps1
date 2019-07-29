function Get-OctoPSJob {
    <#
    .SYNOPSIS
        Get current job information on one or more stored on a OctoPrint server.
    .DESCRIPTION
        Get current job information on one or more stored on a OctoPrint server.
    .EXAMPLE
        PS > Get-OctoPSJob -SkipCertificateCheck        


        File          : Concealed_Cuff_Key.gcode
        Completion    : 100%
        FilePosition  : 744661
        PrintTime     : 00:14:03
        PrintTimeLeft : 00:00:00
        Progress      : 
        Target        : @{AveragePrintTime=843.760487348773; EstimatedPrintTime=872.828690189309; Filament=; File=; LastPrintTIme=843.760487348773}
        FileInfo      : @{date=1562790860; display=Concealed Cuff Key.gcode; name=Concealed_Cuff_Key.gcode; origin=local; path=Concealed_Cuff_Key.gcode; size=744661}
        State         : Operational
        HostId        : 1

        Get information on the current job. 

    .INPUTS
        Int32
    .OUTPUTS
        OctoPrint.Job
    #>
    [CmdletBinding(DefaultParameterSetName = "All")]
    param (
        # Printer Host Id
        [Parameter(Mandatory=$false,
                   ParameterSetName = 'Index',
                   Position=0)]
        [int32[]]
        $Id = @(),

        # Skips certificate validation checks. This includes all validations such as expiration, revocation, trusted root authority, etc.
        [Parameter(Mandatory = $false)]
        [switch]
        $SkipCertificateCheck
    )
    
    begin {
        $RestMethodParams = @{
            'Method'        = "Get"
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

            $RestMethodParams.Add('URI',"$($h.Uri)/api/job")
            $RestMethodParams.Add('Headers',@{'X-Api-Key' = $h.ApiKey})

            if ($SkipCertificateCheck)
            {
                $RestMethodParams.Add('SkipCertificateCheck', $SkipCertificateCheck)
            }

            Invoke-RestMethod @RestMethodParams| Foreach-Object {
                $JobProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
                $TargetInfoProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary

                # Create an object for the job target info.
                $TargetInfoProps.Add('AveragePrintTime',$_.job.averagePrintTime)
                $TargetInfoProps.Add('EstimatedPrintTime',$_.job.estimatedPrintTime)
                $TargetInfoProps.Add('Filament',$_.job.filament)
                $TargetInfoProps.Add('File',$_.job.file)
                $TargetInfoProps.Add('LastPrintTIme',$_.job.lastPrintTIme)
                $TargetInfoObj = New-Object -TypeName psobject -Property $TargetInfoProps

                # Progress Info
                $JobProps.Add('File',$_.job.file.Name)
                $JobProps.Add('Completion', "$([int]$_.progress.completion)%")
                $JobProps.Add('FilePosition', $_.progress.filepos)
                $tspt =  [timespan]::fromseconds($_.progress.printTime)
                $printTime = ($tspt.ToString("hh\:mm\:ss"))
                $JobProps.Add('PrintTime', $printTime)
                $tspl =  [timespan]::fromseconds($_.progress.printTimeLeft)
                $printTimeLeft = ($tspl.ToString("hh\:mm\:ss"))
                $JobProps.Add('PrintTimeLeft', $printTimeLeft)

                $JobProps.Add('Progress',$ProgressObj)
                $JobProps.Add('Target', $TargetInfoObj)
                $JobProps.Add('FileInfo',$_.job.file)
                $JobProps.Add('State', $_.state)
                $JobProps.Add('HostId',$h.Id)
                $jObj = New-Object -TypeName psobject -Property $JobProps
                $jObj.pstypenames[0] = 'OctoPrint.Job'
                $jObj
            }
        }
    }

    end {
    }
}