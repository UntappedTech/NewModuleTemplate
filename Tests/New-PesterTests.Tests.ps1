# Requires -Module Pester
Describe "New-PesterTests" {

    BeforeAll {
        # Import the module under test
        $moduleRoot = Join-Path $PSScriptRoot '..' | Resolve-Path
        $manifest = Join-Path $moduleRoot 'NewModuleTemplate.psd1'
        Import-Module $manifest -Force
    }

    It "Creates starter test file" {
        $root = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        $temp = Join-Path $root "TestModule"

        New-Item -ItemType Directory -Path $temp | Out-Null

        New-PesterTests -Name "TestModule" -ModulePath $temp

        Test-Path "$temp\Tests\TestModule.Tests.ps1" | Should -Be $true
    }
}
