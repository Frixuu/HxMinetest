# HxMinetest

> **Warning**:
> **Haxe 4.3.0 is now required.** If you're on 4.2.5 or below, please update.

**TL;DR:** HxMinetest is for people who want to make big Minetest mods, but don't enjoy Lua.  
**Heavily WIP.** Things will be broken. PRs welcome.

Do you already know how to make Minetest mods?
Check out our [examples](examples) to see how your knowledge will translate.

Are you new to Minetest modding?
The following resources assume you're writing Lua,
but are a great help in learning the ropes:

- [Minetest Modding Book](https://rubenwardy.com/minetest_modding_book/en/index.html), by rubenwardy
- [Lua Modding API reference](https://minetest.gitlab.io/minetest/)

## Contents

- [Installation](#installation)
- [Quick start](#quick-start)
- [Server-side modding](#server-side-modding)
- [Client-side modding](#client-side-modding)
- [Extras](#extras)
  - [Text components](#text-components)

## Installation

Assuming you already have a [recent version of Haxe installed](https://haxe.org/download/),
you can just run:

```sh
haxelib git hxminetest https://github.com/Frixuu/HxMinetest.git
```

_([Haxelib](https://lib.haxe.org/p/hxminetest/) version is outdated and not recommended.)_

## Quick start

You can bootstrap a new project by running:

```sh
haxelib run hxminetest new my_awesome_mod
```

This creates a new folder called ```my_awesome_mod``` in your current working directory.  
Note: Minetest does not understand Haxe natively. To use your mod, you need to build it:

```sh
cd my_awesome_mod
haxe build.hxml
```

## Server-side modding

By default, HxMinetest is set up for server-side mods.

```haxe
final storage = Minetest.getModStorage();
Minetest.registerOnPlayerJoin((player, _) -> {
    final name = player.getPlayerName();
    final visits = storage.getInt(name);
    Minetest.log(Action, '$name just joined; been here $visits times already');
    storage.setInt(name, visits + 1);
});
```

## Client-side modding

You can switch HxMinetest to client-side mode.  
To do that, add ```--define csm``` to your ```build.hxml``` file.

```haxe
Minetest.registerOnDamageTaken(_ -> Minetest.disconnect());
```

> **Note**: You cannot be in server- and client-side mode at the same time.

## Extras

Aside from 1:1 externs,
HxMinetest is bundled with a bunch of other utilities
that can make your modding journey less painful:

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
