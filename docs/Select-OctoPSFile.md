---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Select-OctoPSFile

## SYNOPSIS
Select a file for printing on a OctoPrint server.

## SYNTAX

### none (Default)
```
Select-OctoPSFile [-SkipCertificateCheck] -Path <String> [-Location <String>] [-Print] [<CommonParameters>]
```

### Index
```
Select-OctoPSFile [[-Id] <Int32[]>] [-SkipCertificateCheck] -Path <String> [-Location <String>] [-Print]
 [<CommonParameters>]
```

## DESCRIPTION
Select a file for printing on a OctoPrint server.
The file may be located on the printer SD Card or Local to the OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Select-OctoPSFile -Id 1 -SkipCertificateCheck -Location Local -Path xyzCalibration_cube.gcode
```

Select the xyzCalibration_cube.gcode on the local storage.

### EXAMPLE 2
```
Select-OctoPSFile -Id 1 -SkipCertificateCheck -Location Local -Path xyzCalibration_cube.gcode -Print
```

Select the xyzCalibration_cube.gcode on the local storage and start printing it.

## PARAMETERS

### -Id
Printer Host Id

```yaml
Type: Int32[]
Parameter Sets: Index
Aliases: HostId

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

### -Path
Name of the file to select.

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

### -Location
Location of the files.

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

### -Print
Print selected file.

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
