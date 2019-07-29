---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Get-OctoPSFile

## SYNOPSIS
Get a list of files and their info from a OctoPrint Server.

## SYNTAX

### All (Default)
```
Get-OctoPSFile [-Recurse] [-SkipCertificateCheck] [-Name <String>] [-FileType <String[]>] [-Location <String>]
 [<CommonParameters>]
```

### Index
```
Get-OctoPSFile [[-Id] <Int32[]>] [-Recurse] [-SkipCertificateCheck] [-Name <String>] [-FileType <String[]>]
 [-Location <String>] [<CommonParameters>]
```

## DESCRIPTION
Get a list of files and their info from a OctoPrint Server.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSFile -FileType model -SkipCertificateCheck
```

Name       : Fang_CR10_Short_40mm_Space.stl
    Date       : 1/1/01 12:02:32 AM
    Origin     : local
    Path       : Fang_CR10_Short_40mm_Space.stl
    Type       : model
    Size       : 1872084
    Hash       : 4420b2437bf986feebd37437581e2b341a675c0e
    Prints     :
    statistics :
    References : @{download=http://192.168.1.237/downloads/files/local/Fang_CR10_Short_40mm_Space.stl; resource=http://192.168.1.237/api/files/local/Fang_CR10_Short_40mm_Space.stl}
    HostId     : 1

Pull only model files from the server.

### EXAMPLE 2
```
Get-OctoPSFile -SkipCertificateCheck -FileType MachineCode
```

Name       : 3DBenchy.gcode
    Date       : 1/1/01 12:02:36 AM
    Location   : local
    Path       : 3DBenchy.gcode
    Type       : machinecode
    Size       : 3889019
    Hash       : c7821d986cef37a82e2c4c8cad5c96e626643d5f
    Prints     : @{failure=1; last=; success=0}
    statistics : @{averagePrintTime=; lastPrintTime=}
    References : @{download=https://192.168.1.237/downloads/files/local/3DBenchy.gcode; resource=https://192.168.1.237/api/files/local/3DBenchy.gcode}
    HostId     : 1

    Pull only MachineCode files from the server.

### EXAMPLE 3
```
Get-OctoPSFile -Id 1 -FileType MachineCode -SkipCertificateCheck -Name *xyz*
```

Find all gcode files with xyz in the name.

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
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recurse
Recurse though subfolders.

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

### -Name
Name of the file to get.
Accepts wildcards.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -FileType
Type of file to list.
STL = Model, GCode = MachineCode.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @('machinecode','model')
Accept pipeline input: False
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
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.IO.FileInfo
## OUTPUTS

### OctoPrint.File
## NOTES

## RELATED LINKS
