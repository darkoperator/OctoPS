---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Select-OctoPSTool

## SYNOPSIS
Select the default tool for a printer on a OctoPrint server.

## SYNTAX

```
Select-OctoPSTool [[-Id] <Int32[]>] [-SkipCertificateCheck] [-Tool <String>] [<CommonParameters>]
```

## DESCRIPTION
Select the default tool for a printer on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Select-OctoPSTool -Tool tool1 -Id 1 -SkipCertificateCheck
```

Set tool1 as the default tool on the OctoPrint server with Id 1

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

### -Tool
Tool to make the default one.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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
