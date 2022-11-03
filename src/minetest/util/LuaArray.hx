package minetest.util;

import haxe.iterators.ArrayIterator;
import lua.Table;

abstract LuaArray<T>(Table<Int, T>) from Table<Int, T> to Table<Int, T> {

    /**
        Copies contents of an `Array` to a new table/Lua array.
    **/
    @:from
    public static function fromArray<T>(arr: Array<T>): LuaArray<T> {
        final luaArray: Table<Int, T> = Table.create();
        for (element in arr) {
            Table.insert(luaArray, element);
        }
        return luaArray;
    }

    /**
        Copies contents of this table/Lua array to a Haxe array.
    **/
    @:to
    public function copyToArray(): Array<T> {
        final luaArr: Table<Int, T> = this;
        final arr: Array<T> = [];
        untyped __lua__("for _, v in _G.ipairs(luaArr) do arr:push(v); end");
        return arr;
    }

    public inline function iterator(): ArrayIterator<T> {
        return new ArrayIterator(copyToArray());
    }
}
