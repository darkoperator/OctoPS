---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Get-OctoPSFolder

## SYNOPSIS
Get name and information on folders on a OctoPrint server.

## SYNTAX

### All (Default)
```
Get-OctoPSFolder [-Recurse] [-SkipCertificateCheck] [-Name <String>] [<CommonParameters>]
```

### Index
```
Get-OctoPSFolder [[-Id] <Int32[]>] [-Recurse] [-SkipCertificateCheck] [-Name <String>] [<CommonParameters>]
```

### Targeted
```
Get-OctoPSFolder [-Recurse] [-Path <String>] [-SkipCertificateCheck] [-Name <String>] [<CommonParameters>]
```

## DESCRIPTION
Get name and information on folders on a OctoPrint server.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSFolder -Id 1 -SkipCertificateCheck -Recurse
```

List all folders and subfolders on a OctoPrint server.

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

### -Path
Path to list folders for

```yaml
Type: String
Parameter Sets: Targeted
Aliases:

Required: False
Position: Named
Default value: None
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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Name of the folder to get.
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### OctoPrint.Host'
## OUTPUTS

### OctoPrint.Folder
## NOTES

## RELATED LINKS
