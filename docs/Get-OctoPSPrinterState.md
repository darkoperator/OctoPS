---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Get-OctoPSPrinterState

## SYNOPSIS
Retrieves the current state of the printer on a OctoPrint server.

## SYNTAX

```
Get-OctoPSPrinterState [[-Id] <Int32[]>] [-SkipCertificateCheck] [-History] [-Limit <Int32>]
 [-ExcludeTemperature] [-ExcludeState] [-ExcludeSD] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the current state of the printer.
Returned information includes:

* Temperature information
* SD state (if available)
* General printer state

Temperature information can also be made to include the printer's temperature
history by supplying the History parameter.
The amount of data points to return
here can be limited using the Limit parameter, has a default value of 1.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSPrinterState -SkipCertificateCheck
```

Explanation of what the example does

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

### -History
Include temperature history of actions and temperatures.

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

### -Limit
Number of entries from the history log to pull.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeTemperature
Exclude temeprature from hoistory.

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

### -ExcludeState
Exclude state from hoistory.

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

### -ExcludeSD
Exclude SD from hoistory.

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

### Inputs (if any)
## OUTPUTS

### Output (if any)
## NOTES
General notes

## RELATED LINKS
