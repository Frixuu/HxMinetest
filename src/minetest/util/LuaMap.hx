package minetest.util;

import lua.Table;

abstract LuaMap<K, V>(Table<K, V>) from Table<K, V> to Table<K, V> {

    /**
        Copies contents of a `Map` to a new table/Lua map.
    **/
    @:from
    public static function fromMap<K, V>(map: Map<K, V>): LuaMap<K, V> {
        return Table.fromMap(map);
    }

    /**
        Copies contents of this table/Lua map to a Haxe map.
    **/
    @:to
    public function copyToMap(): Map<K, V> {
        return Table.toMap(this);
    }
}
