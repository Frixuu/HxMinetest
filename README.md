# HxMinetest

Haxe externs (and more) for the game Minetest.  
**Heavily WIP.** PRs welcome.

## Install

- from Haxelib (may be outdated):
  - ```haxelib install hxminetest```
- from source (latest):
  - ```git clone``` this repo
  - run ```haxelib dev hxminetest /path/to/cloned/repo```

## Scaffold a new project

```bash
haxelib run hxminetest new my_awesome_mod
cd my_awesome_mod
haxe build.hxml
```

## Examples

### Text components

HxMinetest comes with a message builder inspired by [kyori's adventure library](https://github.com/KyoriPowered/adventure):

```haxe
final tr = Component.getTranslator("dialogue_domain");
player.sendChatMessage(tr("[Villager]")
    // Components can be raw text
    .append(Component.text(" "))
    // They can also be translatable on the client
    .append(tr("You've saved us, @1! We're grateful.",
        // Use the longer syntax
        Component.translate("generic_domain", "hero")
            .color(Color.rgb(255, 132, 87))
            .build()))
    .build());
```
