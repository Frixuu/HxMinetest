package minetest.worldgen;

import minetest.math.Vector;
import minetest.util.LuaArray;
import haxe.extern.EitherType;

class BiomeDefinition {
    @:native("name")
    public var name: String;

    @:native("node_dust")
    public var nodeDust: Null<String>;

    @:native("node_top")
    public var nodeTop: Null<String>;

    @:native("depth_top")
    public var depthTop: Null<Int>;

    @:native("node_filler")
    public var nodeFiller: Null<String>;

    @:native("depth_filler")
    public var depthFiller: Null<Int>;

    @:native("node_stone")
    public var nodeStone: Null<String>;

    @:native("node_water_top")
    public var nodeWaterTop: Null<String>;

    @:native("depth_water_top")
    public var depthWaterTop: Null<Int>;

    @:native("node_water")
    public var nodeWater: Null<String>;

    @:native("node_river_water")
    public var nodeRiverWater: Null<String>;

    @:native("node_riverbed")
    public var nodeRiverBed: Null<String>;

    @:native("depth_riverbed")
    public var depthRiverBed: Null<Int>;

    @:native("node_cave_liquid")
    public var nodeCaveLiquid: Null<EitherType<LuaArray<String>, String>>;

    @:native("node_dungeon")
    public var nodeDungeon: Null<String>;

    @:native("node_dungeon_alt")
    public var nodeDungeonAlt: Null<String>;

    @:native("node_dungeon_stair")
    public var nodeDungeonStair: Null<String>;

    @:native("y_max")
    public var yMax: Null<Int>;

    @:native("y_min")
    public var yMin: Null<Int>;

    @:native("max_pos")
    public var maxPos: Null<Vector>;

    @:native("min_pos")
    public var minPos: Null<Vector>;

    @:native("vertical_blend")
    public var verticalBlend: Int;

    @:native("heat_point")
    public var heatPoint: Null<Int>;

    @:native("humidity_point")
    public var humidityPoint: Null<Int>;

    public function new(name: String) {
        this.name = name;
        this.verticalBlend = 0;
    }
}
