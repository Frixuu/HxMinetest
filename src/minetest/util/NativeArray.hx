package minetest.util;

import lua.Lua;
import lua.Table;

abstract NativeArray<T>(Table<Int, T>) from Table<Int, T> to Table<Int, T> {

    /**
        Copies contents of an `Array` to a new table/Lua array.
    **/
    @:from
    public static function fromArray<T>(arr: Array<T>): NativeArray<T> {
        return Table.fromArray(arr);
    }

    public inline function toArray(): Array<T> {
        return Table.toArray(this);
    }

    /**
        Creates a new `NativeArray`.
    **/
    public inline function new() {
        this = Table.create();
    }

    @:op([])
    @:pure
    public inline function get(index: Int): Null<T> {
        return this[index];
    }

    @:op([])
    public inline function set(index: Int, value: T): T {
        return this[index] = value;
    }

    /**
        The length of this `NativeArray`.
    **/
    public var length(get, never): Int;

    private inline function get_length(): Int {
        return untyped __lua__("#{0}", this);
    }

    public inline function push(value: T): Int {
        Table.insert(this, value);
        return abstract.length;
    }

    /**
        Modifies this `NativeArray` in place
        by removing the last element and returning it.
    **/
    public inline function pop(): Null<T> {
        return untyped Table.remove(this);
    }

    /**
        Modifies this `NativeArray` in place
        by removing the first element and returning it.
    **/
    public inline function shift(): Null<T> {
        return untyped Table.remove(this, 1);
    }

    public inline function unshift(value: T): Void {
        Table.insert(this, 1, value);
    }

    public inline function iterator(): Iterator<T> {
        return new Iterator(this);
    }
}

@:dox(hide)
class Iterator<T> {
    private var nextFunc: (Table<Int, T>, Int) -> NextResult<Int, T>;
    private var table: Table<Int, T>;
    private var index: Int;

    public function new<K>(tbl: Table<Int, T>) {
        final result = Lua.ipairs(tbl);
        this.nextFunc = cast result.next;
        this.table = result.table;
        this.index = result.index;
    }

    public function hasNext(): Bool {
        return this.nextFunc(this.table, this.index) != null;
    }

    public function next(): T {
        final newPair = this.nextFunc(this.table, this.index);
        this.index = newPair.index;
        return newPair.value;
    }
}
