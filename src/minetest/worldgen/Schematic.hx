package minetest.worldgen;

abstract Schematic(Any) {
    private function new(repr: Any) {
        this = repr;
    }

    @:from
    public static function fromFilename(name: String): Schematic {
        return new Schematic(name);
    }

    @:from
    public static function fromRawData(raw: SchematicData): Schematic {
        return new Schematic(raw);
    }
}
