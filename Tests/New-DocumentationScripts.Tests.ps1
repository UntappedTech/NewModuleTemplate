# Requires -Module Pester
Describe "New-DocumentationScripts" {

    BeforeAll {
        # Import the module under test
        $moduleRoot = Join-Path $PSScriptRoot '..' | Resolve-Path
        $manifest = Join-Path $moduleRoot 'NewModuleTemplate.psd1'
        Import-Module $manifest -Force
    }

    BeforeEach {
        # Fresh temp directory for each test
        $guid = [guid]::NewGuid().ToString()
        $root = Join-Path $env:TEMP $guid

        New-Item -ItemType Directory -Path $root | Out-Null

        Set-Variable -Name TempRoot -Value $root -Scope Local
    }

    It "Creates the Scripts directory and documentation update script" {
        $result = New-DocumentationScripts -ModulePath $TempRoot -Name "TestModule"

        $scriptsDir = Join-Path $TempRoot "Scripts"
        $expectedPath = Join-Path $scriptsDir "Update-ModuleDocumentation.ps1"

        # Directory exists
        Test-Path $scriptsDir | Should -Be $true

        # Script exists
        Test-Path $expectedPath | Should -Be $true

        # Function returns correct path
        $result | Should -Be $expectedPath
    }

    It "Replaces __MODULE_NAME__ correctly inside the script" {
        $path = New-DocumentationScripts -ModulePath $TempRoot -Name "TestModule"
        $lines = Get-Content $path

        # Script should import PlatyPS
        $lines | Should -Contain "Import-Module PlatyPS -ErrorAction Stop"

        # Script should import the module manifest using the correct name
        $lines | Should -Contain 'Import-Module "$PSScriptRoot\..\TestModule.psd1" -Force'

        # Script should call New-MarkdownHelp with the correct module name
        $lines | Should -Contain 'New-MarkdownHelp -Module TestModule -OutputFolder "$PSScriptRoot\..\Docs\" -WithModulePage -Force'
    }

    It "Is idempotent and overwrites the script cleanly" {
        # First write
        New-DocumentationScripts -ModulePath $TempRoot -Name "TestModule"

        # Second write should not throw
        {
            New-DocumentationScripts -ModulePath $TempRoot -Name "TestModule"
        } | Should -Not -Throw

        # Script still contains correct module name
        $lines = Get-Content (Join-Path $TempRoot "Scripts\Update-ModuleDocumentation.ps1")
        $lines | Should -Contain 'New-MarkdownHelp -Module TestModule -OutputFolder "$PSScriptRoot\..\Docs\" -WithModulePage -Force'
    }
}
