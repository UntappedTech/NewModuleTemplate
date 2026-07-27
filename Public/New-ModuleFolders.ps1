function New-ModuleFolders {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Path
    )

    # Base module path: <Path>\<Name>
    $base = Join-Path $Path $Name
    New-Item -ItemType Directory -Path $base -Force | Out-Null

    # Standard module folder structure
    foreach ($folder in 'Public', 'Private', 'Tests', 'Docs', 'Analyzer', 'Scripts') {
        New-Item -ItemType Directory -Path (Join-Path $base $folder) -Force | Out-Null
    }

    return $base
}
