# Requires -Module Pester

Describe "NewModuleTemplate Module" {

    BeforeAll {
        $moduleRoot = Join-Path $PSScriptRoot '..' | Resolve-Path
        $manifest = Join-Path $moduleRoot 'NewModuleTemplate.psd1'
        Import-Module $manifest -Force
    }

    It "Loads without error" {
        { Import-Module $manifest -Force } | Should -Not -Throw
    }

    It "Exports at least one function" {
        ((Get-Command -Module NewModuleTemplate).Count -gt 0) | Should -Be $true
    }
}
