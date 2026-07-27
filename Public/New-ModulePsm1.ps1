function New-ModulePsm1 {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$BasePath
    )

    $psm1Path = Join-Path $BasePath "$Name.psm1"

    $content = @'
# Auto-generated module file for {0}

Set-StrictMode -Version Latest

# Import public functions
Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" | ForEach-Object {
    . $_.FullName
}

# Import private functions
Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" | ForEach-Object {
    . $_.FullName
}

# Export only public functions
$publicFunctions = Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" |
    ForEach-Object {
        $match = Select-String -Path $_.FullName -Pattern '^function\s+([^\s{]+)'
        if ($match) { $match.Matches.Groups[1].Value }
    }

Export-ModuleMember -Function $publicFunctions
'@ -f $Name

    Set-Content -Path $psm1Path -Value $content -Encoding UTF8

    return $psm1Path
}
