package minetest.data;

typedef PlayerHealthChangeReason = {
    var type: ChangeType;
    var from: InvokedFrom;
    @:optional var object: Any;
    @:optional var node: Any;
}

enum abstract InvokedFrom(String) {
    public var Mod = "mod";
    public var Engine = "engine";
}

enum abstract ChangeType(String) {

    /**
        The health change was not given a type.
        This usually means this is a custom damage type.
    **/
    public var Custom = "set_hp";

    /**
        The player was punched.
        The `object` field should hold the puncher.
    **/
    public var Punch = "punch";
    public var Fall = "fall";

    /**
        Damage taken from a neighboring node.
        The `node` field should hold the node name.
    **/
    public var NodeDamage = "node_damage";
    public var Drown = "drown";
    public var Respawn = "respawn";
}
