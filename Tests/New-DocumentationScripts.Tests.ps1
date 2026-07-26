Describe "New-DocumentationScripts" {

    It "Creates documentation scripts" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-DocumentationScripts -Name "TestModule" -Path $temp

        Test-Path "$temp\TestModule\Docs\New-Help.ps1" | Should Be $true
    }
}
