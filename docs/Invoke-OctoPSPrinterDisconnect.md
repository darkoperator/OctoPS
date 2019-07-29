---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Invoke-OctoPSPrinterDisconnect

## SYNOPSIS
Issue to OctoPrint a command to disconnect the printer.

## SYNTAX

```
Invoke-OctoPSPrinterDisconnect [[-Id] <Int32[]>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Issue to OctoPrint a command to disconnect the printer.

## EXAMPLES

### EXAMPLE 1
```
Invoke-OctoPSPrinterDisconnect
```

PS C:\\\>  Get-OctoPSPrinterConnection


    Profile  : _default
    State    : Closed
    Port     :
    BoudRate :
    Options  : @{baudratePreference=115200; baudrates=System.Object\[\]; portPreference=VIRTUAL; ports=System.Object\[\]; printerProfilePreference=cr-10s;
            printerProfiles=System.Object\[\]}
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

## OUTPUTS

## NOTES

## RELATED LINKS
