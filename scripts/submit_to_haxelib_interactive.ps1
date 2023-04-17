#Requires -Version 7.0

using namespace System.IO

[string]$projectRoot = $PSScriptRoot | Split-Path -Parent
[string]$now = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd'T'HH-mm-ss'Z'")
[string]$random = 1..4 | ForEach-Object -Process { '{0:X}' -f (Get-Random -Max 16) } | Join-String -Separator ""
[string]$zipPath = Join-Path $projectRoot "hxminetest_$($now)_$($random).zip"

[FileInfo]$archiveFile = @(
    # Config files used by Haxe tooling
    "haxelib.json", "*.hxml",
    # Sources
    "src", "templates",
    # Legal
    "LICENSE.txt",
    # Renders summary on the lib.haxe.org website
    "README.md"
)
| ForEach-Object -Process { Join-Path $projectRoot $_ }
| Get-Item
| Compress-Archive -DestinationPath $zipPath -CompressionLevel Optimal -PassThru

Write-Output "Created .zip file, size is $($archiveFile.Length) bytes"

haxelib submit $zipPath
