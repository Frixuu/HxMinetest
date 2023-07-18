// SPDX-License-Identifier: Zlib
package minetest.util;

import lua.Lua;
import lua.Table;

/**
 * A collection that contains no duplicate elements.
 */
abstract NativeSet<T>(Table<T, Bool>) to Table<T, Bool> {

    /**
     * Creates a new `NativeSet`.
     */
    @:pure
    public inline function new() {
        this = Table.create();
    }

    /**
     * Checks if an element already exists in the set.
     */
    @:pure
    public inline function has(value: T): Bool {
        return this[untyped value] == true;
    }

    /**
     * Adds `value` to the set, if possible.
     * @return False, if `value` already exists in the set.
     */
    public inline function insert(value: T): Bool {
        return if (abstract.has(value)) {
            false;
        } else {
            this[untyped value] = true;
            true;
        };
    }

    /**
     * Removes `value` from the set.
     * @return False if `value` never existed in the set.
     */
    public inline function remove(value: T): Bool {
        return if (abstract.has(value)) {
            @:nullSafety(Off) this[untyped value] = null;
            true;
        } else {
            false;
        };
    }

    public inline function iterator(): SetIterator<T> {
        return new SetIterator(this);
    }
}

@:dox(hide)
class SetIterator<T> {
    private var tbl: Table<T, Bool>;
    private var fn: (Table<T, Bool>, T) -> T;
    private var index: T;

    public function new(tbl: Table<T, Bool>) {
        final result = Lua.pairs(tbl);
        this.tbl = result.table;
        this.fn = cast result.next;
        this.index = result.index;
    }

    public function hasNext(): Bool {
        return this.fn(this.tbl, this.index) != null;
    }

    public function next(): T {
        final newIndex = this.fn(this.tbl, this.index);
        this.index = newIndex;
        return newIndex;
    }
}
