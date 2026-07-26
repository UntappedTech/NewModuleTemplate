<#
.SYNOPSIS
    Creates a publish.ps1 script inside the generated module.

.DESCRIPTION
    The publish script pushes the module to the PowerShell Gallery.
#>
function New-PublishScript {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

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

    $content = $content.Replace('__MODULE__', $Name)

    Set-Content -Path "$BasePath\Scripts\publish.ps1" -Value $content
}
