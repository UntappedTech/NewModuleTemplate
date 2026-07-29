<#
.SYNOPSIS
    Initializes a new Git repository inside a module folder.

.DESCRIPTION
    Creates a .gitignore file, initializes a Git repository, stages all files,
    and performs an initial commit. This function is used by New-ModuleTemplate
    when the -InitGit switch is provided.

.PARAMETER ModulePath
    The root directory of the module where the Git repository should be created.
    This must be the module's top-level folder (e.g., C:\Projects\MyModule).

.EXAMPLE
    Initialize-GitRepository -ModulePath "C:\Projects\MyModule"

.EXAMPLE
    $root = "C:\Modules\Tools"
    Initialize-GitRepository -ModulePath $root

.NOTES
    - Requires Git to be installed and available in PATH.
    - This function performs a commit with the message "Initial commit".
#>
function Initialize-GitRepository {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ModulePath
    )

    Write-Verbose "Initializing Git repository in '$ModulePath'."

    # Check for Git
    $git = Get-Command git -ErrorAction SilentlyContinue
    if (-not $git) {
        Write-Warning "Git is not installed or not on PATH. Skipping repository initialization."
        return
    }

    Write-Debug "Git detected at: $($git.Source)"

    # Write .gitignore
    Write-Verbose "Writing .gitignore file."
    $gitignorePath = Join-Path $ModulePath '.gitignore'

    $gitignore = @'
# Ignore PowerShell module build output
*.ps1xml
*.cdxml
*.xsd

# Ignore compiled help files
*.dll
*.exe
*.pdb

# Ignore NuGet/PSGallery package files
*.nupkg
*.zip

# Ignore temporary files
*.tmp
*.log
*.bak
*.swp
*.swo

# Ignore VS Code settings and workspace files
.vscode/
.history/

# Ignore PlatyPS temp files
Docs/*.xml

# Ignore PowerShellGet cache
PSGetModuleInfo.xml

# Ignore build output folders
bin/
obj/
out/
Release/
Debug/

# Ignore test results
TestResults/
*.trx
*.coverage
*.coveragexml

# Ignore OS-specific files
.DS_Store
Thumbs.db
ehthumbs.db
desktop.ini

# Ignore user-specific files
*.user
*.suo
*.userosscache
*.sln.docstates

'@

    Set-Content -Path $gitignorePath -Value $gitignore -Encoding UTF8

    # Initialize repository
    Write-Verbose "Running 'git init' inside '$ModulePath'."
    Push-Location $ModulePath
    git init | Out-Null
    Pop-Location

    # Stage files
    Write-Verbose "Staging initial files."
    git -C $ModulePath add . | Out-Null

    # Commit
    Write-Verbose "Creating initial commit."
    git -C $ModulePath commit -m "Initial commit" | Out-Null

    Write-Information "Git repository initialized successfully in '$ModulePath'."

    return $gitignorePath
}
