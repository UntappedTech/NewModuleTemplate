<#
.SYNOPSIS
    Creates the folder structure for a new PowerShell module.

.DESCRIPTION
    Generates the standard directory layout used by your module scaffolding
    system. This includes the Public, Private, Tests, Docs, Analyzer, and
    Scripts directories. The function returns the full path to the module's
    root folder.

.PARAMETER BasePath
    The directory where the module folder will be created. The module root
    becomes <BasePath>\<Name>.

.PARAMETER Name
    The name of the module. This becomes the root folder name and is used
    throughout the scaffolding process.

.EXAMPLE
    New-ModuleFolders -BasePath "C:\Projects" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-ModuleFolders -BasePath $root -Name "Tools"

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
        [string]$Name
    )

    # Build the module root path: <BasePath>\<Name>
    $moduleRoot = Join-Path $Path $Name

    # Create the root folder
    New-Item -ItemType Directory -Path $moduleRoot -Force | Out-Null

    # Create the standard module subfolders
    foreach ($folder in 'Public', 'Private', 'Tests', 'Docs', 'Analyzer', 'Scripts') {
        New-Item -ItemType Directory -Path (Join-Path $moduleRoot $folder) -Force | Out-Null
    }

    # Return the module root path for chaining
    return $moduleRoot
}
