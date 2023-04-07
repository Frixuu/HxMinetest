#Requires -Version 7.0

using namespace System.Management.Automation

[ApplicationInfo]$haxe = Get-Command "haxe" -CommandType Application -ErrorAction SilentlyContinue
if ($haxe) {
    $version = [SemanticVersion]::new(@(haxe --version)[0]);
    if ([SemanticVersion]::new(4, 2, 5) -ge $version) {
        throw "Haxe compiler found, but it is too old (have: $version, must be: 4.3.0)"
    }
}
else {
    throw "Haxe compiler not found"
}
