param(
    [Parameter(Mandatory)]
    [string]$ApiKey,

    [string]$Repository = 'PSGallery'
)

$modulePath = Split-Path -Parent $PSScriptRoot

Write-Information "Publishing NewModuleTemplate from $modulePath to $Repository..."

Publish-Module -Path $modulePath -Repository $Repository -NuGetApiKey $ApiKey

Write-Information "Publish complete."
