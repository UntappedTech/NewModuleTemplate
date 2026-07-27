function New-PesterTests {
    param(
        [string]$Name,
        [string]$BasePath
    )

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

    $test = $test.Replace('__MODULE__', $Name)

    Set-Content "$BasePath\Tests\$Name.Tests.ps1" $test

}
