<#
.SYNOPSIS
    Creates or updates a CHANGELOG.md file for the module.

.DESCRIPTION
    Generates a Markdown changelog file following the "Keep a Changelog" format
    and Semantic Versioning guidelines. The function writes a new changelog
    entry using the provided version and notes. If the file does not exist,
    it is created. If it exists, the new entry is appended.

.PARAMETER ModulePath
    The root directory of the module where CHANGELOG.md will be created.

.PARAMETER Version
    The version number associated with the changelog entry.
    Defaults to "1.0.0".

.PARAMETER Notes
    A description of the changes included in this version.
    Defaults to "Initial release."

.EXAMPLE
    New-ModuleChangelog -ModulePath "C:\Projects\MyModule" -Version "1.2.0" -Notes "Added new API endpoints"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-ModuleChangelog -ModulePath $root -Version "0.1.0" -Notes "Prototype scaffolding"

.NOTES
    - This function is typically invoked by New-ModuleTemplate.
    - The changelog format follows https://keepachangelog.com/.
#>
function New-ModuleChangelog {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ModulePath,

        [Parameter()]
        [string]$Version = "1.0.0",

        [Parameter()]
        [string]$Notes = "Initial release."
    )

    Write-Verbose "Creating changelog for module version '$Version'."

    # Ensure module directory exists
    Ensure-Directory -Path $ModulePath -Name 'Module root'

    # Path to the changelog file
    $changelogPath = Join-Path $ModulePath "CHANGELOG.md"

    # Build the changelog entry
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

    # Write the changelog file
    Write-FileContent -Path $changelogPath -Content $content -Name 'Changelog'

    return $changelogPath
}

