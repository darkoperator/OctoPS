---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Publish-OctoPSFile

## SYNOPSIS
Upload a file to a specified location on a OctoPrint server.

## SYNTAX

```
Publish-OctoPSFile [-Id <Int32[]>] [-Path] <String> [-Select] [-Print] [-Location <String>]
 [-RemotePath <String>] [-SkipCertificateCheck] [<CommonParameters>]
```

## DESCRIPTION
Upload a file to a specified location on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Publish-OctoPSFile -Id 1 -Path '/Users/carlos/Desktop/xyzcube.gcode' -Select -Location Local -RemotePath / -SkipCertificateCheck
```

Upload and select a file for printing to the root of the local storage.

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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
File to publish to OctoPrint server.

```yaml
Type: String
Parameter Sets: (All)
Aliases: FullName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Select
Select file after upload.

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

### -Print
Print after upload

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
The path within the location to upload the file

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
### String
## OUTPUTS

### OctoPrint.File
## NOTES
Saving to SDCard is very slow due to the nature of the serial connection between OctoPrint and most printers.

## RELATED LINKS
