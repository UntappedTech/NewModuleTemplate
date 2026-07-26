Set-StrictMode -Version Latest

# Load private functions
Get-ChildItem "$PSScriptRoot\Private" -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

# Load public functions
Get-ChildItem "$PSScriptRoot\Public" -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

Export-ModuleMember -Function @(
    'Initialize-GitRepository',
    'New-AnalyzerSettings',
    'New-BuildScript',
    'New-DocumentationScripts',
    'New-ModuleChangelog',
    'New-ModuleFolders',
    'New-ModuleManifestFile',
    'New-ModuleReadme',
    'New-ModuleTemplate',
    'New-PesterTests',
    'New-PublishScript'
)
