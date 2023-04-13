#Requires -Version 7.3

using namespace System.Management.Automation

[ApplicationInfo]$haxe = Get-Command "haxe" -CommandType Application -ErrorAction SilentlyContinue
if ($haxe) {
    $minVersion = [SemanticVersion]::new(4, 3, 0)
    $version = [SemanticVersion]::Parse(@(haxe --version)[0]);
    if ($minVersion -gt $version) {
        throw "Haxe compiler found, but it is too old (have: $version, must be: $minVersion)"
    }
}
else {
    throw "Haxe compiler not found"
}
