set windows-shell := ["powershell.exe", "-ExecutionPolicy", "Unrestricted", "-NoLogo", "-Command"]

default: set-dev lint build-examples build-docs

install-deps:
    haxelib install haxelib.json --always

install-dev-deps:
    haxelib install dox
    haxelib install formatter

set-dev: install-deps install-dev-deps
    haxelib dev hxminetest .

lint:
    haxelib run formatter --check -s contrib -s examples -s src -s tests

build-examples:
    deno run --allow-run=haxe --allow-read=examples scripts/build-examples.ts

serve-docs:
    vitepress dev docs

build-reference-markdown:
    deno run --allow-run --allow-read=docs --allow-write=docs scripts/generate-class-reference.ts

build-docs: build-reference-markdown
    vitepress build docs

submit-haxelib:
    deno run --allow-run --allow-read --allow-write scripts/submit-to-haxelib-interactive.ts
