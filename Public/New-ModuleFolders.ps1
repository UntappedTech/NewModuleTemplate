function New-ModuleFolders {
    param([string]$Name)

    $base = Join-Path (Get-Location) $Name
    New-Item -ItemType Directory -Path $base -Force | Out-Null

    foreach ($folder in 'Public', 'Private', 'Tests', 'Docs', 'Scripts', 'Analyzer') {
        New-Item -ItemType Directory -Path "$base\$folder" -Force | Out-Null
    }

    return $base
}
