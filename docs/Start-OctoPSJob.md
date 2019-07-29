---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Start-OctoPSJob

## SYNOPSIS
Start the current job on a OctoPrint server.

## SYNTAX

### All (Default)
```
Start-OctoPSJob [-SkipCertificateCheck] [<CommonParameters>]
```

### Index
```
Start-OctoPSJob [-Id <Int32[]>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Start the current job on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Start-OctoPSJob -Id 1 -SkipCertificateCheck
```

Start the current print job on the OctoPrint server with Id 1

## PARAMETERS

### -Id
Printer Host Id

```yaml
Type: Int32[]
Parameter Sets: Index
Aliases:

Required: False
Position: Named
Default value: @()
Accept pipeline input: False
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

## NOTES

## RELATED LINKS
