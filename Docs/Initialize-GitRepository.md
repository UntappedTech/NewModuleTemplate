---
external help file: NewModuleTemplate-help.xml
Module Name: NewModuleTemplate
online version:
schema: 2.0.0
---

# Initialize-GitRepository

## SYNOPSIS
Initializes a new Git repository inside a module folder.

## SYNTAX

```
Initialize-GitRepository [-ModulePath] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a .gitignore file, initializes a Git repository, stages all files,
and performs an initial commit.
This function is used by New-ModuleTemplate
when the -InitGit switch is provided.

## EXAMPLES

### EXAMPLE 1
```
Initialize-GitRepository -ModulePath "C:\Projects\MyModule"
```

### EXAMPLE 2
```
$root = "C:\Modules\Tools"
Initialize-GitRepository -ModulePath $root
```

## PARAMETERS

### -ModulePath
The root directory of the module where the Git repository should be created.
This must be the module's top-level folder (e.g., C:\Projects\MyModule).

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
- Requires Git to be installed and available in PATH.
- This function performs a commit with the message "Initial commit".

## RELATED LINKS
