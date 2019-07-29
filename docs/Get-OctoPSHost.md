---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Get-OctoPSHost

## SYNOPSIS
Get information on one or more stored on a OctoPrint server.

## SYNTAX

```
Get-OctoPSHost [[-Id] <Int32[]>] [<CommonParameters>]
```

## DESCRIPTION
Get information on one or more stored on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSHost
```

Get all configured printers under the current user.

### EXAMPLE 2
```
Get-OctoPSHost -Id 1,3
```

Get configured printers with the Id 1 and 3 for the current user.

## PARAMETERS

### -Id
Printer Host Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Int32
## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES

## RELATED LINKS
