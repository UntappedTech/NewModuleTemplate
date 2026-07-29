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

        [switch]$Minimal
    )

    # Build the module root path: <Path>\<Name>
    $moduleRoot = Join-Path $Path $Name

    # Create the root folder
    New-Item -ItemType Directory -Path $moduleRoot -Force | Out-Null

    # Always create core folders
    foreach ($folder in 'Public', 'Private') {
        New-Item -ItemType Directory -Path (Join-Path $moduleRoot $folder) -Force | Out-Null
    }

    # Create full scaffolding folders only when not minimal
    if (-not $Minimal) {
        foreach ($folder in 'Tests', 'Docs', 'Analyzer', 'Scripts') {
            New-Item -ItemType Directory -Path (Join-Path $moduleRoot $folder) -Force | Out-Null
        }
    }

    return $moduleRoot
}

