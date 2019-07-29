---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Set-OctoPSBed

## SYNOPSIS
Set the bed temparature for a printer on a OctoPrint server.

## SYNTAX

### Temp (Default)
```
Set-OctoPSBed [[-Id] <Int32[]>] [-SkipCertificateCheck] -TargetTemp <Int32> [<CommonParameters>]
```

### Offset
```
Set-OctoPSBed [[-Id] <Int32[]>] [-SkipCertificateCheck] -Offset <Int32> [<CommonParameters>]
```

## DESCRIPTION
Set the bed temparature for a printer on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Set-OctoPSBed -SkipCertificateCheck -TargetTemp 60
```

Set the temperature of the bed to 60 celcius.

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

### -TargetTemp
Temperature to set as targt for the tool in Celcius.

```yaml
Type: Int32
Parameter Sets: Temp
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Offset
Temperature offset.

```yaml
Type: Int32
Parameter Sets: Offset
Aliases:

Required: True
Position: Named
Default value: 0
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
