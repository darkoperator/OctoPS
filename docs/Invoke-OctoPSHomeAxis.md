---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Invoke-OctoPSHomeAxis

## SYNOPSIS
Home all axis of a printer connected to a OctoPrint server.

## SYNTAX

```
Invoke-OctoPSHomeAxis [[-Id] <Int32[]>] [-SkipCertificateCheck] [-Axis <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Home all axis of a printer connected to a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
<Invoke-OctoPSHomeAxis -SkipCertificateCheck -Id 1
```

Home all axis (X, Y and X)

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

### -Axis
Axis to home.
Values can be X, Y or Z, Default value is all 3 axes.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @('X', 'Y', 'Z')
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Int32
## OUTPUTS

## NOTES

## RELATED LINKS
