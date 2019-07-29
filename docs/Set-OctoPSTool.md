---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Set-OctoPSTool

## SYNOPSIS
Set the paramter of a specified tool for temparature and flow rate for a printer on a OctoPrint server.

## SYNTAX

### Temp (Default)
```
Set-OctoPSTool [[-Id] <Int32[]>] [-SkipCertificateCheck] [-Tool <String>] -TargetTemp <Int32>
 [<CommonParameters>]
```

### Offset
```
Set-OctoPSTool [[-Id] <Int32[]>] [-SkipCertificateCheck] [-Tool <String>] -Offset <Int32> [<CommonParameters>]
```

### Flowrate
```
Set-OctoPSTool [[-Id] <Int32[]>] [-SkipCertificateCheck] [-Tool <String>] -FlowRate <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Set the paramter of a specified tool for temparature and flow rate for a printer on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Set-OctoPSTool -Id 1 -SkipCertificateCheck -TargetTemp 210
```

Set the temperature of the default tool0 to 210 celcius.

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
Tool to issue command against.
Defaults to tool0.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Tool0
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

### -FlowRate
Set the flowr ate percentage factor on the selected tool.

```yaml
Type: Int32
Parameter Sets: Flowrate
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
