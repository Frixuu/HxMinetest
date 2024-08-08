// SPDX-License-Identifier: Zlib
package minetest.node;

/**
    A unique numeric identifier for a specific node type.

    To look up the identifier for a given node from its name, use `Minetest.getContentId`.

    To look up the node name string from its ID, use `Minetest.getNameFromContentId`.
**/
abstract ContentId(Int) to Int {

    /**
        Implicitly looks up the ID for a given node name.
    **/
    @:from
    private static inline function fromName(name: String): ContentId {
        return Minetest.getContentId(name);
    }

    /**
        Implicitly looks up the node name for a given ID.
    **/
    @:to
    private inline function toName(): String {
        return Minetest.getNameFromContentId(abstract);
    }
}
