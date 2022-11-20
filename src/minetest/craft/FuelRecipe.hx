package minetest.craft;

import minetest.util.LuaArray;
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
    var replacements: Null<LuaArray<Pair<String, String>>>;

    /**
        Creates a new fuel recipe.
    **/
    public function new(itemName: String, burnTime: Float = 1.0) {
        super(Fuel);
        this.burnTime = burnTime;
        this.itemName = itemName;
        this.replacements = null;
    }
}
