---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Get-OctoPSPrinterConnection

## SYNOPSIS
Get the current printer connection settings and state on a OctoPrint server.

## SYNTAX

```
Get-OctoPSPrinterConnection [[-Id] <Int32[]>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Get the current printer connection settings and state on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSPrinterConnection -SkipCertificateCheck
```

Profile  : cr-10s
State    : Operational
Port     : VIRTUAL
BoudRate :
Options  : @{baudratePreference=115200; baudrates=System.Object\[\]; portPreference=VIRTUAL; ports=System.Object\[\]; printerProfilePreference=cr-10s; printerProfiles=System.Object\[\]}
HostId   : 1

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

### OctoPrint.ConnectionSettings
## NOTES

## RELATED LINKS
