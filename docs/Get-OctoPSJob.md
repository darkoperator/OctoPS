---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Get-OctoPSJob

## SYNOPSIS
Get current job information on one or more stored on a OctoPrint server.

## SYNTAX

### All (Default)
```
Get-OctoPSJob [-SkipCertificateCheck] [<CommonParameters>]
```

### Index
```
Get-OctoPSJob [[-Id] <Int32[]>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Get current job information on one or more stored on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSJob -SkipCertificateCheck
```

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

## PARAMETERS

### -Id
Printer Host Id

```yaml
Type: Int32[]
Parameter Sets: Index
Aliases:

Required: False
Position: 1
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck
Skips certificate validation checks.
This includes all validations such as expiration, revocation, trusted root authority, etc.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Int32
## OUTPUTS

### OctoPrint.Job
## NOTES

## RELATED LINKS
