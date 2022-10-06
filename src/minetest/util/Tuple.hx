package minetest.util;

import lua.Table;

abstract Tuple<T>(Table<Int, T>) {

    /**
        Creates a new `Tuple`.
    **/
    public inline function new(...args: T) {
        this = cast args;
    }

    /**
        Gets 0-indexed element of this `Tuple`.
    **/
    @:arrayAccess public inline function get(index: Int): T
        return this[index + 1];
}
