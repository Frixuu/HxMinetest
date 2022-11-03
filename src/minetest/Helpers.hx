package minetest;

import lua.Table.AnyTable;

@:native("_G")
extern class Helpers {
    @:native("dump")
    public static function dump(obj: Any, ?dumped: AnyTable): String;

    @:native("dump2")
    public static function dump2(obj: Any, ?name: String, ?dumped: AnyTable): String;
}
