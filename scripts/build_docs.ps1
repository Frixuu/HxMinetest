#Requires -Version 7.0

. (Join-Path $PSScriptRoot "ensure_haxe_exists.ps1")

[string]$projectRoot = $PSScriptRoot | Split-Path -Parent
Push-Location $projectRoot

[string[]]$params = @(
    "--class-path", "src",
    "--macro", "include('doctest')",
    "--macro", "include('minetest')",
    "--lua", "not.applicable",
    "--no-output",
    "--xml", "docs/hxminetest.xml"
)

haxe @params
haxelib run dox -i docs -o docs/pages --include "[mM]inetest.*"
