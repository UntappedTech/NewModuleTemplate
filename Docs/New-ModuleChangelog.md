---
external help file: NewModuleTemplate-help.xml
Module Name: NewModuleTemplate
online version:
schema: 2.0.0
---

# New-ModuleChangelog

## SYNOPSIS
Creates or updates a CHANGELOG.md file for the module.

## SYNTAX

```
New-ModuleChangelog [-ModulePath] <String> [[-Version] <String>] [[-Notes] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Generates a Markdown changelog file following the "Keep a Changelog" format
and Semantic Versioning guidelines.
The function writes a new changelog
entry using the provided version and notes.
If the file does not exist,
it is created.
If it exists, the new entry is appended.

## EXAMPLES

### EXAMPLE 1
```
New-ModuleChangelog -ModulePath "C:\Projects\MyModule" -Version "1.2.0" -Notes "Added new API endpoints"
```

### EXAMPLE 2
```
$root = Join-Path $env:TEMP "TestModule"
New-ModuleChangelog -ModulePath $root -Version "0.1.0" -Notes "Prototype scaffolding"
```

## PARAMETERS

### -ModulePath
The root directory of the module where CHANGELOG.md will be created.

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

### -Version
The version number associated with the changelog entry.
Defaults to "1.0.0".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 1.0.0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Notes
A description of the changes included in this version.
Defaults to "Initial release."

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Initial release.
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
- This function is typically invoked by New-ModuleTemplate.
- The changelog format follows https://keepachangelog.com/.

## RELATED LINKS
