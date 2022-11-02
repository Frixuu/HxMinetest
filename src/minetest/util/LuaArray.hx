package minetest.util;

import lua.Table;

abstract LuaArray<T>(Table<Int, T>) from Table<Int, T> to Table<Int, T> {
    @:to
    public function copyToArray(): Array<T> {
        final luaArr: Table<Int, T> = this;
        final arr: Array<T> = [];
        untyped __lua__("for _, v in _G.ipairs(luaArr) do arr:push(v); end");
        return arr;
    }
}
