---
# https://vitepress.dev/reference/default-theme-home-page
layout: "home"

hero:
  name: "HxMinetest"
  tagline: "Type-safe tooling to help you bring your dream Minetest mods to life."
  actions:
    - theme: "brand"
      text: "Get started"
      link: "/guide/getting-started"
    - theme: "alt"
      text: "API reference"
      link: "/reference/minetest/Minetest"

features:
  - title: "You already know it"
    details: "No need to learn new APIs. All the fan favorites are here, just with a bit more *class*."
  - title: "Strictly-typed"
    details: "Move runtime errors to compile-time. Always correctly call functions. Supercharge your experience with Haxe's language server."
  - title: "...with safety hatches"
    details: "Reinterpret cast anything, inline Lua code for performance, hijack private implementation details. We don't judge."
  - title: "Batteries included (soon)"
    details: "Not just language bindings. Simplify creating chat commands, formspecs, and more."
  - title: "Dependency management"
    details: "Use package managers like Haxelib, Lix or Hmm to include Haxe libraries in your project. Insecure mods can still use LuaRocks modules."
  - title: "Embrace the build step"
    details: "Use powerful AST macros. No more dofile() hell; bundle all your code to a single file."
---

