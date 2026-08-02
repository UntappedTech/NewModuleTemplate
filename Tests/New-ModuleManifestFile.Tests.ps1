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

        $data = Test-ModuleManifest -Path $manifestPath

        # GUID should be non-empty and valid
        { [guid]::Parse($data.Guid) } | Should -Not -Throw
    }

    It "Manifest imports without error" {
        $manifestPath = New-ModuleManifestFile -ModulePath $TempRoot -Name "TestModule"

        {
            Import-Module $manifestPath -Force
        } | Should -Not -Throw
    }
}
