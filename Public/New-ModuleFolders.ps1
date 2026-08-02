<#
.SYNOPSIS
    Creates the folder structure for a new PowerShell module.

.DESCRIPTION
    Generates the standard directory layout used by your module scaffolding
    system. This includes the Public, Private, Tests, Docs, Analyzer, and
    Scripts directories. The function returns the full path to the module's
    root folder.

.PARAMETER ModulePath
    The directory where the module folder will be created. The module root
    becomes <ModulePath>\<Name>.

.PARAMETER Name
    The name of the module. This becomes the root folder name and is used
    throughout the scaffolding process.

.PARAMETER Minimal
    Generates only the essential module directories:
    - Public/Private folders
    Skips tests, docs, analyzer settings, and scripts.
    
.EXAMPLE
    New-ModuleFolders -ModulePath "C:\Projects" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-ModuleFolders -ModulePath $root -Name "Tools"

.NOTES
    - This function is invoked internally by New-ModuleTemplate.
    - The folder names are intentionally kept as: Public, Private, Tests,
      Docs, Analyzer, Scripts.
#>
function New-ModuleFolders {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$Name,

        [switch]$Minimal,
        [switch]$NoTests,
        [switch]$NoDocs,
        [switch]$NoAnalyzer,
        [switch]$NoScripts
    )

    $moduleRoot = Join-Path $Path $Name

    # Create root
    New-Item -ItemType Directory -Path $moduleRoot -Force | Out-Null

    # Always create core folders
    foreach ($folder in 'Public', 'Private') {
        New-Item -ItemType Directory -Path (Join-Path $moduleRoot $folder) -Force | Out-Null
    }

    # Full scaffolding only when not minimal
    if (-not $Minimal) {

        if (-not $NoTests) {
            New-Item -ItemType Directory -Path (Join-Path $moduleRoot 'Tests') -Force | Out-Null
        }

        if (-not $NoDocs) {
            New-Item -ItemType Directory -Path (Join-Path $moduleRoot 'Docs') -Force | Out-Null
        }

        if (-not $NoAnalyzer) {
            New-Item -ItemType Directory -Path (Join-Path $moduleRoot 'Analyzer') -Force | Out-Null
        }

        if (-not $NoScripts) {
            New-Item -ItemType Directory -Path (Join-Path $moduleRoot 'Scripts') -Force | Out-Null
        }
    }

    return $moduleRoot
}


