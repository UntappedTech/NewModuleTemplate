<#
.SYNOPSIS
    Initializes a new Git repository inside a module folder.

.DESCRIPTION
    Creates a .gitignore file, initializes a Git repository, stages all files,
    and performs an initial commit. This function is used by New-ModuleTemplate
    when the -InitGit switch is provided.

.PARAMETER BasePath
    The root directory of the module where the Git repository should be created.
    This must be the module's top-level folder (e.g., C:\Projects\MyModule).

.EXAMPLE
    Initialize-GitRepository -BasePath "C:\Projects\MyModule"

.EXAMPLE
    $root = "C:\Modules\Tools"
    Initialize-GitRepository -BasePath $root

.NOTES
    - Requires Git to be installed and available in PATH.
    - This function performs a commit with the message "Initial commit".
#>
function Initialize-GitRepository {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath
    )

    # Create a standard .gitignore file for PowerShell modules
    $gitignore = @'
## Build artifacts
bin/
obj/

# VSCode
.vscode/

# PlatyPS temp files
Docs/*.xml

# PowerShellGet publish cache
*.nupkg

# Logs
*.log
'@

    # Write .gitignore to the module root
    Set-Content -Path "$BasePath\.gitignore" -Value $gitignore -Encoding UTF8

    # Initialize the Git repository inside the module folder
    Push-Location $BasePath
    git init | Out-Null
    Pop-Location

    # Stage all files and create the initial commit
    git -C $BasePath add . | Out-Null
    git -C $BasePath commit -m "Initial commit" | Out-Null
}
