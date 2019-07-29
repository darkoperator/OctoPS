---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Remove-OctoPSItem

## SYNOPSIS
Delete a specified file or folder from a OctoPrint server.

## SYNTAX

```
Remove-OctoPSItem [[-Id] <Int32[]>] [-Location <String>] -Path <String> [<CommonParameters>]
```

## DESCRIPTION
Deletes a specified file or folder from a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSItem -FileType model | Remove-OctoPrintFile -verbose
```

Delete all model files from the first OctoPrint Server.

## PARAMETERS

### -Id
Printer Host Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: HostId

Required: False
Position: 1
Default value: @()
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Location
Location where file is at.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Local
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Path of file to remove including name of the file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### OctoPrint.File
### OctoPrint.Folder
## OUTPUTS

## NOTES

## RELATED LINKS
