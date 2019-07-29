---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Invoke-OctoPSToolExtrude

## SYNOPSIS
Extrude a given amount of material on the default tool for a printer on a OctoPrint server.

## SYNTAX

```
Invoke-OctoPSToolExtrude [[-Id] <Int32[]>] [-SkipCertificateCheck] [-Speed <Int32>] -Amount <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Extrude a given amount of material on the default tool for a printer on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Invoke-OctoPSToolExtrude -Id 1 -SkipCertificateCheck -Speed 100 -Amount 20
```

Extrude 20mm of material at 100mm per minute.

## PARAMETERS

### -Id
OctoPrint Host Id

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

### -Speed
Speed for extruding material in millimeters per minute.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Amount
Ammount of material to extrude in millimeters, if a negative value is provide the extruder will retract.

```yaml
Type: Int32
Parameter Sets: (All)
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
### Int
## OUTPUTS

## NOTES

## RELATED LINKS
