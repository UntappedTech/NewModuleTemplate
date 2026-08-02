# Requires -Module Pester
Describe "New-ModuleManifestFile" {

    BeforeEach {
        # Fresh temp directory for each test
        $root = Join-Path $env:TEMP ([guid]::NewGuid().ToString())

        New-Item -ItemType Directory -Path $root | Out-Null

        Set-Variable -Name TempRoot -Value $root -Scope Local
    }

    It "Creates a manifest file at the expected path" {
        $result = New-ModuleManifestFile -ModulePath $TempRoot -Name "TestModule"

        $expectedPath = Join-Path $TempRoot "TestModule.psd1"
        $result | Should -Be $expectedPath
        Test-Path $expectedPath | Should -Be $true
    }

    It "Generates a unique GUID" {
        $manifestPath = New-ModuleManifestFile -ModulePath $TempRoot -Name "TestModule"

        $data = Import-PowerShellDataFile $manifestPath

        # GUID should be non-empty and valid
        { [guid]::Parse($data.Guid) } | Should -Not -Throw
    }

    It "Includes only the expected FileList entries" {
        $manifestPath = New-ModuleManifestFile -ModulePath $TempRoot -Name "TestModule"

        $data = Import-PowerShellDataFile $manifestPath

        $data.FileList | Should -Contain "TestModule.psm1"
        $data.FileList | Should -Contain "TestModule.psd1"
        $data.FileList | Should -Contain "Public"
        $data.FileList | Should -Contain "Private"

        # Ensure no unexpected folders are included
        $data.FileList | Should -Not -Contain "Docs"
        $data.FileList | Should -Not -Contain "Tests"
        $data.FileList | Should -Not -Contain "Scripts"
        $data.FileList | Should -Not -Contain "Analyzer"
    }
}
