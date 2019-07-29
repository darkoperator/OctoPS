---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Set-OctoPSHost

## SYNOPSIS
Saves a new OctoPrint host for use of the cmdlets.

## SYNTAX

```
Set-OctoPSHost -Name <String> -Uri <Uri> -ApiKey <String> [<CommonParameters>]
```

## DESCRIPTION
Saves a new OctoPrint host for use of the cmdlets.
On *nix hosts it is stored in ~/.octops/printservers.json
on Windows hosts it is stored in $($Env:AppData)\.octops\printservers.json.

## EXAMPLES

### EXAMPLE 1
```
Set-OctoPSHost -Name CR-10_01 -Uri https://192.168.1.20 -ApiKey 5DC40C3C5BFB41709AC37D3DA558BA28
```

Saves a new printer in the configuration called CR-10_01

## PARAMETERS

### -Name
Friendly name for OctoPi Server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
URI to the OctoPrint host in \<http|https\>://\<host\>:\<port\> format

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApiKey
API Key

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String
## OUTPUTS

## NOTES

## RELATED LINKS
