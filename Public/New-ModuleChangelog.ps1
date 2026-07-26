function New-ModuleChangelog {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$Version,

        [Parameter()]
        [string]$Notes = "Initial release."
    )

    # Ensure the path exists
    if (-not (Test-Path $Path)) {
        throw "The path '$Path' does not exist."
    }

    $changelogPath = Join-Path $Path "CHANGELOG.md"

    # Build content
    $date = (Get-Date).ToString("yyyy-MM-dd")

    $content = @"
# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [$Version] - $date
### Added
- $Notes

"@

    # Write file
    Set-Content -Path $changelogPath -Value $content -Encoding UTF8

    # Return the path for convenience
    return $changelogPath
}
