// SPDX-License-Identifier: Zlib
package minetest.util;

import lua.Lua;
import lua.Table;

abstract NativeSet<T>(Table<T, Bool>) to Table<T, Bool> {
    @:pure
    public inline function has(value: T): Bool {
        return this[untyped value] == true;
    }

    public inline function insert(value: T): Bool {
        return if (abstract.has(value)) {
            false;
        } else {
            this[untyped value] = true;
            true;
        };
    }

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
