// SPDX-License-Identifier: Zlib
package minetest.node;

/**
    A unique numeric identifier for a specific node type.

    To look up the identifier for a given node from its name, use `Minetest.getContentId`.

    To look up the node name string from its ID, use `Minetest.getNameFromContentId`.
**/
abstract ContentId(Int) to Int {}
