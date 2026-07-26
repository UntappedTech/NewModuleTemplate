Describe "New-PesterTests" {

    It "Creates starter test file" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-PesterTests -Name "TestModule" -Path $temp

        Test-Path "$temp\TestModule\Tests\TestModule.Tests.ps1" | Should Be $true
    }
}
