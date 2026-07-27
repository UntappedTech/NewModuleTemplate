<#
.SYNOPSIS
    Creates the module loader (.psm1) file for the generated PowerShell module.

.DESCRIPTION
    Generates the primary module file that PowerShell loads when the module is
    imported. The loader automatically imports all public and private functions
    and exports only the public ones. This ensures a clean separation between
    internal helpers and the module's public API.

.PARAMETER BasePath
    The root directory of the module where the .psm1 file will be created.

.PARAMETER Name
    The name of the module. Determines the filename (<Name>.psm1) and is used
    inside the generated loader script.

.EXAMPLE
    New-ModuleLoader -BasePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-ModuleLoader -BasePath $root -Name "TestModule"

.NOTES
    - The here-string is intentionally single-quoted.
    - The placeholder __MODULE__ is replaced after the here-string is defined.
    - No escaping is performed inside the here-string.
#>
function New-ModuleLoader {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    # Path to the .psm1 file
    $loaderPath = Join-Path $BasePath "$Name.psm1"

    # Template for the module loader (single-quoted, no escaping)
    $content = @'
# Auto-generated module file for __MODULE__

Set-StrictMode -Version Latest

# Import public functions
Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" | ForEach-Object {
    . $_.FullName
}

# Import private functions
Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" | ForEach-Object {
    . $_.FullName
}

# Export only public functions
$publicFunctions = Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" |
    ForEach-Object {
        $match = Select-String -Path $_.FullName -Pattern '^function\s+([^\s{]+)'
        if ($match) { $match.Matches.Groups[1].Value }
    }

Export-ModuleMember -Function $publicFunctions
'@

    # Replace placeholder with module name
    $content = $content.Replace('__MODULE__', $Name)

    # Write the loader file
    Set-Content -Path $loaderPath -Value $content -Encoding UTF8

    return $loaderPath
}
