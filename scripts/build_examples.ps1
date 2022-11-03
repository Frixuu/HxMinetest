#Requires -Version 7.0

$haxe = Get-Command "haxe" -ErrorAction SilentlyContinue
if ($haxe) {
    $versionOutput = @(haxe --version)[0]
    $version = $versionOutput.Split(".") | ForEach-Object -Process { $_ -as [int] };
    $versionMajor = $version[0]
    $versionMinor = $version[1]
    if (($versionMajor -lt 4) -or (($versionMajor -eq 4) -and ($versionMinor -lt 2))) {
        throw "Haxe compiler found, but it is too old of a version"
    }
}
else {
    throw "Haxe compiler not found"
}

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
