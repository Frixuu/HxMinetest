// SPDX-License-Identifier: Zlib
package minetest.util;

import lua.Lua;
import lua.Table;

/**
    An interface for a regular Lua table/map with native semantics (no null values).
**/
abstract NativeMap<K, V>(Table<K, V>) from Table<K, V> to Table<K, V> {

    /**
        Creates a new `NativeMap`.
    **/
    public inline function new() {
        this = Table.create();
    }

    /**
        Copies contents of a `Map` to a new table/Lua map.
    **/
    @:from
    public static function fromMap<K, V>(map: Map<K, V>): NativeMap<K, V> {
        @:nullSafety(Off) return Table.fromMap(map);
    }

    /**
        Returns the value currently associated with `key` or `null` if no mapping exists.

        Note that `NativeMap` does not differentiate between null values and absent keys.
    **/
    @:op([])
    @:pure
    public inline function get(key: K): Null<V> {
        return this[untyped key];
    }

    /**
        Sets the value associated with `key` to `value`.
    **/
    @:op([])
    public inline function set(key: K, value: V): V {
        return this[untyped key] = value;
    }

    /**
        Returns true if `key` has a non-null mapping, false otherwise.
    **/
    public inline function exists(key: K): Bool {
        return abstract.get(key) != null;
    }

    public inline function keys(): Iterator<K> {
        return new KeyIterator(this);
    }

    public inline function iterator(): Iterator<V> {
        return new ValueIterator(this);
    }

    public inline function keyValueIterator(): KeyValueIterator<K, V> {
        return new KeyValueIterator(this);
    }

    /**
        Removes the mapping for `key`, if it exists.
        @return True if the mapping was removed, false if it did not exist.
    **/
    public inline function remove(key: K): Bool {
        return if (abstract.get(key) != null) {
            @:nullSafety(Off) abstract.set(key, null);
            true;
        } else {
            false;
        }
    }
}

@:dox(hide)
class KeyIterator<K> {
    private var nextFunc: (Table<K, Any>, K) -> K;
    private var table: Table<K, Any>;
    private var index: K;

    public function new<V>(tbl: Table<K, V>) {
        final result = Lua.pairs(tbl);
        this.nextFunc = cast result.next;
        this.table = result.table;
        this.index = result.index;
    }

    public function hasNext(): Bool {
        return this.nextFunc(this.table, this.index) != null;
    }

    public function next(): K {
        final newIndex = this.nextFunc(this.table, this.index);
        this.index = newIndex;
        return newIndex;
    }
}

@:dox(hide)
class ValueIterator<V> {
    private var nextFunc: (Table<Any, V>, Any) -> NextResult<Any, V>;
    private var table: Table<Any, V>;
    private var index: Any;

    public function new<K>(tbl: Table<K, V>) {
        final result = Lua.pairs(tbl);
        this.nextFunc = cast result.next;
        this.table = result.table;
        this.index = result.index;
    }

    public function hasNext(): Bool {
        return this.nextFunc(this.table, this.index) != null;
    }

    public function next(): V {
        final newPair = this.nextFunc(this.table, this.index);
        this.index = newPair.index;
        return newPair.value;
    }
}

@:dox(hide)
class KeyValueIterator<K, V> {
    private var nextFunc: (Table<K, V>, K) -> NextResult<K, V>;
    private var table: Table<K, V>;
    private var index: K;

    public function new(tbl: Table<K, V>) {
        final result = Lua.pairs(tbl);
        this.nextFunc = result.next;
        this.table = result.table;
        this.index = result.index;
    }

    public function hasNext(): Bool {
        return this.nextFunc(this.table, this.index) != null;
    }

    public function next(): {key: K, value: V} {
        final newPair = this.nextFunc(this.table, this.index);
        this.index = newPair.index;
        return {key: newPair.index, value: newPair.value};
    }
}
