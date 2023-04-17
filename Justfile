set windows-shell := ["powershell.exe", "-ExecutionPolicy", "Unrestricted", "-NoLogo", "-Command"]

default: set-dev build-examples build-docs

install-deps:
    haxelib install haxelib.json --always
    haxelib install dox

set-dev: install-deps
    haxelib dev hxminetest .

build-examples:
    deno run --allow-run=haxe --allow-read=examples scripts/build-examples.ts

build-docs:
    haxe --class-path src --library partials --macro "include('doctest')" --macro "include('minetest')" --lua not.applicable --xml docs/hxminetest.xml --no-output
    haxelib run dox -i docs -o docs/pages --include "[mM]inetest.*"

submit-haxelib:
    deno run --allow-run --allow-read --allow-write scripts/submit-to-haxelib-interactive.ts
