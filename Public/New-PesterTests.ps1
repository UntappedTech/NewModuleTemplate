<#
.SYNOPSIS
    Creates a basic Pester test file for the generated module.

.DESCRIPTION
    Generates a Pester test script that:
    - Imports the module manifest
    - Verifies the module loads without error
    - Ensures at least one function is exported
    This provides a minimal but meaningful test suite for new modules.

.PARAMETER BasePath
    The root directory of the module where the Tests folder exists.

.PARAMETER Name
    The name of the module. Used to populate placeholders inside the test file.

.EXAMPLE
    New-PesterTests -BasePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-PesterTests -BasePath $root -Name "TestModule"

.NOTES
    - The here-string is intentionally single-quoted.
    - No escaping or interpolation occurs inside the here-string.
    - Placeholders (__MODULE__) are replaced afterward.
#>
function New-PesterTests {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    # Template for the Pester test file (single-quoted, no escaping)
    $test = @'
Describe "__MODULE__ Module" {

    BeforeAll {
        Import-Module "$PSScriptRoot/../__MODULE__.psd1" -Force
    }

    It "Loads without error" {
        { Import-Module "__MODULE__" -Force } | Should -Not -Throw
    }

    It "Exports at least one function" {
        (Get-Command -Module "__MODULE__").Count | Should -BeGreaterThan 0
    }
}
'@

    # Replace placeholder with module name
    $test = $test.Replace('__MODULE__', $Name)

    # Path to the test file
    $testPath = Join-Path $BasePath "Tests\$Name.Tests.ps1"

    # Write the test file
    Set-Content -Path $testPath -Value $test -Encoding UTF8 -Force
}
