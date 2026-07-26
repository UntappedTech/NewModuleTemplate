function New-ModuleManifestFile {
    param(
        [string]$Name,
        [string]$BasePath
    )

    $guid = [guid]::NewGuid().ToString()

    New-ModuleManifest -Path "$BasePath\$Name.psd1" `
        -RootModule "$Name.psm1" `
        -ModuleVersion "1.0.0" `
        -Author $env:USERNAME `
        -Description "$Name module" `
        -Guid $guid `
        -FunctionsToExport @('ExampleFunction') `
        -AliasesToExport @() `
        -CompatiblePSEditions @('Core', 'Desktop') `
        -PowerShellVersion '5.1' `
        -PrivateData @{ PSData = @{ Tags = @('PowerShell', 'Module') } } | Out-Null
}
