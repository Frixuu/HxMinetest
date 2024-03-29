package minetest.util;

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
}
