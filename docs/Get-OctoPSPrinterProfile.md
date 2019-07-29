---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Get-OctoPSPrinterProfile

## SYNOPSIS
Get the current printer connection settings and state on a OctoPrint server.

## SYNTAX

```
Get-OctoPSPrinterProfile [[-Id] <Int32[]>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Get the current printer connection settings and state on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSJob -SkipCertificateCheck -Id 1
```

File          : Concealed_Cuff_Key.gcode
    Completion    : 100%
    FilePosition  : 744661
    PrintTime     : 00:14:03
    PrintTimeLeft : 00:00:00
    Progress      : 
    Target        : @{AveragePrintTime=843.760487348773; EstimatedPrintTime=872.828690189309; Filament=; File=; LastPrintTIme=843.760487348773}
    State         : Operational
    HostId        : 1

Get the printer connection settings.

## PARAMETERS

### -Id
OctoPrint Host  Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: @()
Accept pipeline input: True (ByPropertyName)
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

### OctoPrint.PrinterProfile
## NOTES

## RELATED LINKS
