---
external help file: NewModuleTemplate-help.xml
Module Name: NewModuleTemplate
online version:
schema: 2.0.0
---

# New-ModuleLoader

## SYNOPSIS
Creates the module loader (.psm1) file for the generated PowerShell module.

## SYNTAX

```
New-ModuleLoader [-ModulePath] <String> [-Name] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Generates the primary module file that PowerShell loads when the module is
imported.
The loader automatically imports all public and private functions
and exports only the public ones.
This ensures a clean separation between
internal helpers and the module's public API.

## EXAMPLES

### EXAMPLE 1
```
New-ModuleLoader -ModulePath "C:\Projects\MyModule" -Name "MyModule"
```

### EXAMPLE 2
```
$root = Join-Path $env:TEMP "TestModule"
New-ModuleLoader -ModulePath $root -Name "TestModule"
```

## PARAMETERS

### -ModulePath
The root directory of the module where the .psm1 file will be created.

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
Determines the filename (\<Name\>.psm1) and is used
inside the generated loader script.

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
- The here-string is intentionally single-quoted.
- The placeholder __MODULE__ is replaced after the here-string is defined.
- No escaping is performed inside the here-string.

## RELATED LINKS
