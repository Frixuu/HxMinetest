// SPDX-License-Identifier: Zlib
package minetest.worldgen;

import minetest.node.ContentId;
import lua.Table;

typedef BufferTable = Table<Int, ContentId>;

/**
    Contains bulk data about node contents in Content ID format.
**/
abstract NodeContentBuffer(BufferTable) from BufferTable to BufferTable {

    /**
        Creates a new, empty buffer.
    **/
    public inline function new() {
        this = Table.create();
    }

    /**
        Gets the ID of a node at the given index.

        Note: The position this index is refering to depends on your emerged area.
    **/
    public inline function get(index: Int): ContentId {
        return this[index];
    }

    /**
        Sets the ID of a node at the given index.

        Note: The position this index is refering to depends on your emerged area.
    **/
    public inline function set(index: Int, value: ContentId) {
        this[index] = value;
    }
}
