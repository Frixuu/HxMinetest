#Requires -Version 7.0

. (Join-Path $PSScriptRoot "ensure_haxe_exists.ps1")

$projectRoot = $PSScriptRoot | Split-Path -Parent
$examplesRoot = Join-Path -Path $projectRoot -ChildPath "examples"
$examplePaths = $examplesRoot | Get-ChildItem -Directory
Write-Output "Compiling $($examplePaths.Length) examples..."
foreach ($examplePath in $examplePaths) {
    Set-Location -Path $examplePath
    $name = Split-Path -Path $examplePath -Leaf
    haxe build.hxml
    if ($LASTEXITCODE -eq 0) {
        Write-Output "$($name): OK"
    }
    else {
        Write-Output "$($name): FAILED"
        throw "Build failed. Check above for details."
    }
}
