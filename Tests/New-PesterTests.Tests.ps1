Describe "New-PesterTests" {

    It "Creates starter test file" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString()) "TestModule"
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-PesterTests -Name "TestModule" -ModulePath $temp

        Test-Path "$temp\Tests\TestModule.Tests.ps1" | Should Be $true
    }
}
