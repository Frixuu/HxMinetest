package minetest.util;

import lua.Table;

abstract NativeMap<K, V>(Table<K, V>) from Table<K, V> to Table<K, V> {

    /**
        Copies contents of a `Map` to a new table/Lua map.
    **/
    @:from
    public static function fromMap<K, V>(map: Map<K, V>): NativeMap<K, V> {
        @:nullSafety(Off) return Table.fromMap(map);
    }
}
