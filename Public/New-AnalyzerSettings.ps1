function New-AnalyzerSettings {
    param([string]$BasePath)

    $content = @'
@{
    Severity = @{
        PSAvoidUsingWriteHost = 'Warning'
        PSProvideCommentHelp = 'Information'
    }
}
'@

    Set-Content -Path "$BasePath\Analyzer\PSScriptAnalyzerSettings.psd1" -Value $content
}
