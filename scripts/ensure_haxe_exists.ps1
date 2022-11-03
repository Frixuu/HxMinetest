#Requires -Version 7.0

using namespace System.Management.Automation

$haxe = Get-Command "haxe" -ErrorAction SilentlyContinue
if ($haxe) {
    $minVersion = [SemanticVersion]::new(4, 2, 5)
    $version = [SemanticVersion]::new(@(haxe --version)[0]);
    if ($version -lt $minVersion) {
        throw "Haxe compiler found, but it is too old of a version"
    }
}
else {
    throw "Haxe compiler not found"
}
