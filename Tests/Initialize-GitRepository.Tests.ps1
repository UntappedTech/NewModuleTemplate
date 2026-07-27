Describe "Initialize-GitRepository" {

    It "Initializes a git repository" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        Initialize-GitRepository -BasePath $temp

        Test-Path "$temp\.git" | Should Be $true
    }
}
