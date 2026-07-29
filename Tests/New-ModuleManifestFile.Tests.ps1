Describe "New-ModuleManifestFile" {

    It "Creates a valid manifest" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString()) "TestModule"
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-ModuleManifestFile -Name "TestModule" -ModulePath $temp

        $manifestPath = "$temp\TestModule.psd1"
        Test-Path $manifestPath | Should Be $true

        $manifest = Test-ModuleManifest $manifestPath
        $manifest.RootModule | Should Be "TestModule.psm1"
    }
}
