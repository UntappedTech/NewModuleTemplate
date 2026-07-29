<#
.SYNOPSIS
    Creates the module loader (.psm1) file for the generated PowerShell module.

.DESCRIPTION
    Generates the primary module file that PowerShell loads when the module is
    imported. The loader automatically imports all public and private functions
    and exports only the public ones. This ensures a clean separation between
    internal helpers and the module's public API.

.PARAMETER ModulePath
    The root directory of the module where the .psm1 file will be created.

.PARAMETER Name
    The name of the module. Determines the filename (<Name>.psm1) and is used
    inside the generated loader script.

.EXAMPLE
    New-ModuleLoader -ModulePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-ModuleLoader -ModulePath $root -Name "TestModule"

.NOTES
    - The here-string is intentionally single-quoted.
    - The placeholder __MODULE__ is replaced after the here-string is defined.
    - No escaping is performed inside the here-string.
#>
function New-ModuleLoader {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ModulePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    Write-Verbose "Creating module loader for '$Name'."

    # Ensure module root exists
    Ensure-Directory -Path $ModulePath -Name 'Module root'

    # Path to the .psm1 file
    $loaderPath = Join-Path $ModulePath "$Name.psm1"

    # Template for the module loader
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
    Write-FileContent -Path $loaderPath -Content $content -Name 'Module loader'

    return $loaderPath
}

