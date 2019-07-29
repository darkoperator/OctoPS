---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Get-OctoPSBed

## SYNOPSIS
Get the bed temparature, target and offset for a given OctoPrint server.

## SYNTAX

```
Get-OctoPSBed [[-Id] <Int32[]>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Get the bed temparature, target and offset for a given OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSBed -SkipCertificateCheck -Id 1
```

Name        : bed
    Temperature : 20.43
    Target      : 0
    Offset      : 0
    HostId      : 1

Get the temperature for the printer with Id 1.

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

### OctoPrint.BedInfo
## NOTES

## RELATED LINKS
