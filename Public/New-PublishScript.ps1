<#
.SYNOPSIS
    Creates a publish.ps1 script inside the generated module.

.DESCRIPTION
    Generates a PowerShell script that publishes the module to a specified
    PowerShell repository (default: PSGallery). The script requires an API key
    and uses Publish-Module to push the module from its root directory.

.PARAMETER ModulePath
    The root directory of the module where the Scripts folder exists.

.PARAMETER Name
    The name of the module. Used to populate placeholders inside the publish script.

.EXAMPLE
    New-PublishScript -ModulePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-PublishScript -ModulePath $root -Name "TestModule"

.NOTES
    - The here-string is intentionally single-quoted.
    - No escaping or interpolation occurs inside the here-string.
    - Placeholders (__MODULE__) are replaced afterward.
#>
function New-PublishScript {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ModulePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    Write-Verbose "Creating publish script for module '$Name'."

    # Ensure Scripts directory exists
    $scriptsDir = Join-Path $ModulePath 'Scripts'
    Ensure-Directory -Path $scriptsDir -Name 'Scripts'

    # Template for publish.ps1
    $content = @'
param(
    [Parameter(Mandatory)]
    [string]$ApiKey,

    [string]$Repository = "PSGallery"
)

$modulePath = Split-Path -Parent $PSScriptRoot

Write-Information "Publishing __MODULE__ from $modulePath to $Repository..."

Publish-Module -Path $modulePath -Repository $Repository -NuGetApiKey $ApiKey

Write-Information "Publish complete."
'@

    # Replace placeholder with module name
    $content = $content.Replace('__MODULE__', $Name)

    # Write publish.ps1
    $publishPath = Join-Path $scriptsDir 'publish.ps1'
    Write-FileContent -Path $publishPath -Content $content -Name 'Publish script'

    return $publishPath
}
