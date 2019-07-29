---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Remove-OctoPSHost

## SYNOPSIS
Remove a specified OctoPrint from stored host using the Host Id.

## SYNTAX

```
Remove-OctoPSHost [-Id] <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Remove a specified OctoPrint from stored host using the Host Id.

## EXAMPLES

### EXAMPLE 1
```
Remove-OctoPSHost -Id 2
```

Remove a configured host with Id 2

## PARAMETERS

### -Id
OctoPrint Host  Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Int32
## OUTPUTS

## NOTES

## RELATED LINKS
