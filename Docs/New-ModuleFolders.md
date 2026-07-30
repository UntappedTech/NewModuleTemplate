---
external help file: NewModuleTemplate-help.xml
Module Name: NewModuleTemplate
online version:
schema: 2.0.0
---

# New-ModuleFolders

## SYNOPSIS
Creates the folder structure for a new PowerShell module.

## SYNTAX

```
New-ModuleFolders [-Path] <String> [-Name] <String> [-Minimal] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Generates the standard directory layout used by your module scaffolding
system.
This includes the Public, Private, Tests, Docs, Analyzer, and
Scripts directories.
The function returns the full path to the module's
root folder.

## EXAMPLES

### EXAMPLE 1
```
New-ModuleFolders -ModulePath "C:\Projects" -Name "MyModule"
```

### EXAMPLE 2
```
$root = Join-Path $env:TEMP "TestModule"
New-ModuleFolders -ModulePath $root -Name "Tools"
```

## PARAMETERS

### -Path
{{ Fill Path Description }}

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

### -Name
The name of the module.
This becomes the root folder name and is used
throughout the scaffolding process.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minimal
Generates only the essential module directories:
- Public/Private folders
Skips tests, docs, analyzer settings, and scripts.

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

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
- This function is invoked internally by New-ModuleTemplate.
- The folder names are intentionally kept as: Public, Private, Tests,
  Docs, Analyzer, Scripts.

## RELATED LINKS
