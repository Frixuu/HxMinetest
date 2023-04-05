#Requires -Version 7.0

using namespace System.IO

. (Join-Path $PSScriptRoot "ensure_haxe_exists.ps1")

[string]$projectRoot = $PSScriptRoot | Split-Path -Parent
[string]$examplesRoot = Join-Path -Path $projectRoot -ChildPath "examples"
[DirectoryInfo[]]$examplesDirs = $examplesRoot | Get-ChildItem -Directory

Write-Host "Building $($examplesDirs.Length) examples..."

foreach ($examplePath in $examplesDirs) {

    [string]$name = Split-Path -Path $examplePath -Leaf
    Write-Host "$($name): " -NoNewline

    Push-Location -Path $examplePath
    haxe build.hxml
    [bool]$success = $LastExitCode -eq 0
    Pop-Location

    if ($success) {
        Write-Host "OK"
    }
    else {
        Write-Host "FAILED"
        throw "Build failed. Check above for details."
    }
}
