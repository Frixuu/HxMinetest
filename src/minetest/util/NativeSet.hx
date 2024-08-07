// SPDX-License-Identifier: Zlib
package minetest.util;

import lua.Table;

/**
    A collection that contains no duplicate elements.

    Note: Due to having native Lua semantics, elements of this set cannot be numbers.
**/
abstract NativeSet<T>(NativeMap<T, Bool>) to NativeMap<T, Bool> to Table<T, Bool> {

    /**
     * Creates a new `NativeSet`.
     */
    public inline function new() {
        this = new NativeMap();
    }

    @:from
    public static function fromArray<T>(arr: Array<T>): NativeSet<T> {
        final set = new NativeSet<T>();
        for (element in arr) {
            untyped set[element] = true;
        }
        return set;
    }

    /**
     * Checks if an element already exists in the set.
     */
    @:pure
    public inline function has(value: T): Bool {
        return this.get(value) == true;
    }

    /**
     * Adds `value` to the set, if possible.
     * @return False, if `value` already exists in the set.
     */
    public inline function insert(value: T): Bool {
        return if (abstract.has(value)) {
            false;
        } else {
            this.set(value, true);
            true;
        };
    }

    /**
     * Removes `value` from the set.
     * @return False if `value` never existed in the set.
     */
    public inline function remove(value: T): Bool {
        return if (abstract.has(value)) {
            @:nullSafety(Off) this.set(value, null);
            true;
        } else {
            false;
        };
    }

    public inline function iterator(): Iterator<T> {
        return this.keys();
    }
}
