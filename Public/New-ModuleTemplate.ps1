<#
.SYNOPSIS
    Creates a full PowerShell module project scaffold.

.DESCRIPTION
    Generates a professional module structure including:
    - Public/Private folders
    - Tests
    - Docs
    - Analyzer settings
    - PlatyPS documentation script
    - Strict mode
    - Optional Git initialization

.PARAMETER Name
    The name of the module to create.

.PARAMETER UseGui
    Shows a GUI prompt for the module name.

.PARAMETER InitGit
    Initializes a Git repository and adds a .gitignore.

.EXAMPLE
    New-ModuleTemplate -Name MyModule

.EXAMPLE
    New-ModuleTemplate -UseGui

#>
function New-ModuleTemplate {
    [CmdletBinding(DefaultParameterSetName = "CLI")]
    param(
        [Parameter(ParameterSetName = "CLI", Mandatory = $true)]
        [Parameter(ParameterSetName = "GUI")]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(ParameterSetName = "GUI", Mandatory = $true)]
        [switch]$UseGui,

        [switch]$InitGit
    )

    if ($UseGui) {
        $Name = Show-GuiPrompt -Prepopulate $Name -Path $Path
        if (-not $Name) { return }
    }

    # Create folder structure
    $base = New-ModuleFolders -Name $Name -Path $Path

    # Generate module components
    New-ModuleManifestFile     -Name $Name -BasePath $base
    New-PesterTests            -Name $Name -BasePath $base
    New-AnalyzerSettings       -BasePath $base
    New-DocumentationScripts   -Name $Name -BasePath $base
    New-BuildScript            -BasePath $base -Name $Name
    New-PublishScript          -BasePath $base -Name $Name
    New-ModuleReadme           -BasePath $base -ModuleName $Name

    if ($InitGit) {
        Initialize-GitRepository -BasePath $base
    }

    Write-Host "Module '$Name' created at $base"
}
