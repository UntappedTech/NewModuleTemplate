Describe "NewModuleTemplate Module" {

    BeforeAll {
        Import-Module "$PSScriptRoot\..\NewModuleTemplate.psd1" -Force
    }

    It "Loads without error" {
        { Import-Module "$PSScriptRoot\..\NewModuleTemplate.psd1" -Force } | Should Not Throw
    }

    It "Exports at least one function" {
        ((Get-Command -Module NewModuleTemplate).Count -gt 0) | Should Be $true
    }
}
