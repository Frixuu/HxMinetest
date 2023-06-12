package minetest.util;

import lua.Boot;
import lua.Table;

final class NativeArrayTools {

    /**
        Consumes a `Table` and converts it into an `Array`
        without copying its elements.
    **/
    private static function convertIntoHaxeArray<T>(tab: Table<Int, T>): Array<T> {
        return Boot.defArray(tab, null);
    }
}
