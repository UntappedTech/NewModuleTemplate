Describe "New-AnalyzerSettings" {

    It "Creates analyzer settings file" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-AnalyzerSettings -Name "TestModule" -Path $temp

        Test-Path "$temp\TestModule\AnalyzerSettings\Settings.psd1" | Should Be $true
    }
}
