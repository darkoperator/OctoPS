function Get-OctoPSJob {
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
                $ProgressProps = New-Object -TypeName System.Collections.Specialized.OrderedDictionary

                # Create an object for the job target info.
                $TargetInfoProps.Add('AveragePrintTime',$_.job.averagePrintTime)
                $TargetInfoProps.Add('EstimatedPrintTime',$_.job.estimatedPrintTime)
                $TargetInfoProps.Add('Filament',$_.job.filament)
                $TargetInfoProps.Add('File',$_.job.file)
                $TargetInfoProps.Add('LastPrintTIme',$_.job.lastPrintTIme)
                $TargetInfoObj = New-Object -TypeName psobject -Property $TargetInfoProps

                # Progress Object

                $ProgressProps.Add('Completion', "$([int]$_.progress.completion)%")
                $ProgressProps.Add('FilePosition', $_.progress.filepos)
                $tspt =  [timespan]::fromseconds($_.progress.printTime)
                $printTime = ($tspt.ToString("hh\:mm\:ss"))
                $ProgressProps.Add('PrintTime', $printTime)
                $tspl =  [timespan]::fromseconds($_.progress.printTimeLeft)
                $printTimeLeft = ($tspl.ToString("hh\:mm\:ss"))
                $ProgressProps.Add('PrintTimeLeft', $printTimeLeft)
                $ProgressObj = New-Object -TypeName psobject -Property $ProgressProps

                $JobProps.Add('Progress',$ProgressObj)
                $JobProps.Add('Target', $TargetInfoObj)
                $JobProps.Add('State', $_.state)
                $JobProps.Add('HostId',$h.Id)
                $jObj = New-Object -TypeName psobject -Property $JobProps
                $jObj.pstypenames[0] = 'OctoPrint.File'
                $jObj
            }
        }
    }

    end {
    }
}