package minetest.craft;

import lua.Table;
import minetest.util.Pair;

final class FuelRecipe extends Recipe {

    /**
        Burning time this item provides, expressed in seconds.
    **/
    @:native("burntime")
    var burnTime: Float;

    /**
        Itemname of the item to be used as fuel.
    **/
    @:native("recipe")
    var itemName: String;

    @:native("replacements")
    var replacements: Null<Table<Int, Pair<String, String>>>;

    /**
        Creates a new fuel recipe.
    **/
    public function new(itemName: String, burnTime: Float = 1.0) {
        this.type = Fuel;
        this.burnTime = burnTime;
        this.itemName = itemName;
        this.replacements = null;
    }
}
