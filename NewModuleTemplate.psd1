#
# Module manifest for module 'New-ModuleTemplate'


@{
    RootModule           = 'NewModuleTemplate.psm1'
    ModuleVersion        = '1.0.0'
    GUID                 = 'cd7818d1-6b04-4bb5-a644-3a28e7d6db77'
    Author               = 'Kael Sterling'
    CompanyName          = 'Untapped Technologies'
    Description          = 'Module scaffolding generator'
    
    CompatiblePSEditions = 'Core', 'Desktop'
    PowerShellVersion    = '5.1'

    FunctionsToExport    = @(
        'Initialize-GitRepository',
        'New-AnalyzerSettings',
        'New-BuildScript',
        'New-DocumentationScripts',
        'New-ModuleChangelog',
        'New-ModuleFolders',
        'New-ModuleLoader',
        'New-ModuleManifestFile',
        'New-ModuleReadme',
        'New-ModuleTemplate',
        'New-PesterTests',
        'New-PublishScript'
    )
    FileList             = @(
        'NewModuleTemplate.psm1',
        'NewModuleTemplate.psd1',
        'Public',
        'Private'
    )

    AliasesToExport      = @()
    CmdletsToExport      = @()
    DscResourcesToExport = @()
    PrivateData          = @{
        PSData = @{
            Tags         = @('PowerShell', 'Module', 'Scaffolding', 'Generator', 'Template')
            LicenseUri   = 'https://opensource.org/licenses/MIT'
            ProjectUri   = 'https://github.com/UntappedTech/NewModuleTemplate'
            IconUri      = 'https://raw.githubusercontent.com/UntappedTech/NewModuleTemplate/main/icon.svg'
            ReleaseNotes = 'Initial release.'
        }
    }
    
    RequiredModules      = @()
    Copyright            = 'Copyright (c) 2026 Kael Sterling'
    
}

