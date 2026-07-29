<#
.SYNOPSIS
    Creates a module manifest (.psd1) for the generated PowerShell module.

.DESCRIPTION
    Generates a PowerShell module manifest using New-ModuleManifest. The manifest
    includes metadata such as version, author, description, compatible editions,
    and a newly generated GUID. The manifest is written to the module root as
    <Name>.psd1.

.PARAMETER ModulePath
    The root directory of the module where the manifest file will be created.

.PARAMETER Name
    The name of the module. This determines the manifest filename and the
    RootModule entry inside the manifest.

.EXAMPLE
    New-ModuleManifestFile -ModulePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-ModuleManifestFile -ModulePath $root -Name "TestModule"

.NOTES
    - The manifest is created using New-ModuleManifest.
    - FunctionsToExport is intentionally empty; the .psm1 loader handles exports.
#>
function New-ModuleManifestFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ModulePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    Write-Verbose "Creating module manifest for '$Name'."

    # Ensure module root exists
    Ensure-Directory -Path $ModulePath -Name 'Module root'

    # Generate a unique GUID for the module manifest
    $guid = [guid]::NewGuid().ToString()

    # Path to the manifest file
    $manifestPath = Join-Path $ModulePath "$Name.psd1"

    # Create the module manifest
    New-ModuleManifest -Path $manifestPath `
        -RootModule "$Name.psm1" `
        -ModuleVersion "1.0.0" `
        -Author $env:USERNAME `
        -Description "$Name module" `
        -Guid $guid `
        -FunctionsToExport @() `
        -AliasesToExport @() `
        -CompatiblePSEditions @('Core', 'Desktop') `
        -PowerShellVersion '5.1' | Out-Null

    Write-Information "Module manifest created at '$manifestPath'."

    return $manifestPath
}

