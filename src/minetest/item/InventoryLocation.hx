package minetest.item;

import lua.Table;
import minetest.math.Vector;

enum InventoryLocation {
    Player(name: String);
    Node(pos: Vector);
    Detached(name: String);
}

/**
    Converts `InventoryLocation` enum to a native representation.
**/
function toNative(location: InventoryLocation): Table<String, Any> {
    return switch (location) {
        case Player(name):
            Table.create(null, {type: "player", name: name});
        case Node(pos):
            Table.create(null, {type: "node", pos: pos});
        case Detached(name):
            Table.create(null, {type: "detached", name: name});
    }
}
