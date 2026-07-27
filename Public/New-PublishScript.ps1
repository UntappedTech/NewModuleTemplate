<#
.SYNOPSIS
    Creates a publish.ps1 script inside the generated module.

.DESCRIPTION
    Generates a PowerShell script that publishes the module to a specified
    PowerShell repository (default: PSGallery). The script requires an API key
    and uses Publish-Module to push the module from its root directory.

.PARAMETER BasePath
    The root directory of the module where the Scripts folder exists.

.PARAMETER Name
    The name of the module. Used to populate placeholders inside the publish script.

.EXAMPLE
    New-PublishScript -BasePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-PublishScript -BasePath $root -Name "TestModule"

.NOTES
    - The here-string is intentionally single-quoted.
    - No escaping or interpolation occurs inside the here-string.
    - Placeholders (__MODULE__) are replaced afterward.
#>
function New-PublishScript {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    # Template for publish.ps1 (single-quoted, no escaping)
    $content = @'
param(
    [Parameter(Mandatory)]
    [string]$ApiKey,

    [string]$Repository = "PSGallery"
)

$modulePath = Split-Path -Parent $PSScriptRoot

Write-Host "Publishing __MODULE__ from $modulePath to $Repository..."

Publish-Module -Path $modulePath -Repository $Repository -NuGetApiKey $ApiKey

Write-Host "Publish complete."
'@

    # Replace placeholder with module name
    $content = $content.Replace('__MODULE__', $Name)

    # Ensure Scripts directory exists
    $scriptsDir = Join-Path $BasePath 'Scripts'
    if (-not (Test-Path $scriptsDir)) {
        New-Item -ItemType Directory -Path $scriptsDir -Force | Out-Null
    }

    # Write publish.ps1
    $publishPath = Join-Path $scriptsDir 'publish.ps1'
    Set-Content -Path $publishPath -Value $content -Encoding UTF8
}
