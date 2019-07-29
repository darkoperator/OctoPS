---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# New-OctoPSFolder

## SYNOPSIS
Create a new folder either on local storage on a OctoPrint server or the SDcard of a printer.

## SYNTAX

```
New-OctoPSFolder [-Id <Int32[]>] [-FolderName] <String> [-Location <String>] [-RemotePath <String>]
 [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Create a new folder either on local storage on a OctoPrint server or the SDcard of a printer.

## EXAMPLES

### EXAMPLE 1
```
New-OctoPSFolder -Id 1 -FolderName calibration -Location Local -RemotePath / -SkipCertificateCheck
```

Create a new folder called calibration on the root of the local OctoPrint storage.

## PARAMETERS

### -Id
Printer Host Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: HostId

Required: False
Position: Named
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderName
Name of folder to create on remote host..

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
Location to place file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Local
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemotePath
The path within the location to create the folder

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
### Sctring
## OUTPUTS

### OctoPrint.Folder
## NOTES
Saving to SDCard is very slow due to the nature of the serial connection between OctoPrint and most printers.

## RELATED LINKS
