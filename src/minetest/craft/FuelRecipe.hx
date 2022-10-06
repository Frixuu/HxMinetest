package minetest.craft;

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
    var replacements: Null<Any>;

    /**
        Creates a new fuel recipe.
    **/
    public function new(itemName: String, ?burnTime: Float) {
        this.type = Fuel;
        this.burnTime = if (burnTime != null) burnTime; else 1.0;
        this.itemName = itemName;
    }
}
