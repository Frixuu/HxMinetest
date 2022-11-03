#Requires -Version 7.0

. (Join-Path $PSScriptRoot "ensure_haxe_exists.ps1")

$projectRoot = $PSScriptRoot | Split-Path -Parent
$now = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd_HH-mm-ss")
$random = 1..4 | ForEach-Object -Process { '{0:X}' -f (Get-Random -Max 16) } | Join-String -Separator ""
$zipName = "hxminetest-$($now)_$($random).zip"
$zipPath = Join-Path $projectRoot $zipName

"haxelib.json", "LICENSE.txt", "README.md", "src", "*.hxml" |
ForEach-Object -Process { Join-Path $projectRoot $_ } |
Get-Item |
Compress-Archive -DestinationPath $zipPath -CompressionLevel Optimal

haxelib submit $zipPath
