# HxMinetest

**TL;DR:** HxMinetest allows you to easily develop Minetest mods in Haxe.
**Heavily WIP.** PRs welcome.

If you already know how to make mods for Minetest in pure Lua, great!
In most cases, you can just swap ```snake_case``` for ```camelCase```:

```haxe
final storage = Minetest.getModStorage();
Minetest.registerOnPlayerJoin((player, _) -> {
    final name = player.getPlayerName();
    var visits = storage.getInt(name);
    visits += 1;
    storage.setInt(name, visits);
    Minetest.log(Action, 'Hey, $name just joined!');
});
```

## Contents

- [Installation](#installation)
- [Quick start](#quick-start)
- [Client-side modding (experimental)](#client-side-modding-experimental)
- [Extra APIs](#extra-apis)
  - [Text components](#text-components)

## Installation

Assuming you [already have Haxe installed](https://haxe.org/download/),
you can download HxMinetest:

- from [Haxelib](https://lib.haxe.org/p/hxminetest/) (may be outdated):
  - ```haxelib install hxminetest```
- from source (latest):
  - ```git clone``` this repo,
  - run ```haxelib dev hxminetest /path/to/cloned/repo```

## Quick start

First time using Haxe tooling?
HxMinetest can generate the "Hello, World!" for you:

```bash
haxelib run hxminetest new my_awesome_mod
cd my_awesome_mod
haxe build.hxml
```

## Client-side modding (experimental)

HxMinetest can also be used with CSMs.  
Adding ```--define csm``` to your ```build.hxml``` file
will enable client-specific externs (e.g. ```Minetest.localPlayer```)
while disabling the server-specific ones.

## Extra APIs

Common operations can be made easier with the following:

### Text components

HxMinetest comes with a message builder inspired by [kyori's adventure library](https://github.com/KyoriPowered/adventure):

```haxe
final tr = Component.getTranslator("dialogue_domain");
player.sendChatMessage(tr("[Villager]")
    // Components can be raw text
    .append(Component.text(" -> "))
    // They can also be translatable on the client
    .append(tr("You've saved us, @1! We're grateful.",
        // Use the longer syntax
        Component.translate("generic_domain", "hero")
            // Most components can have color data attached
            .color(Color.rgb(255, 132, 87))
            .build()))
    .build());
```
