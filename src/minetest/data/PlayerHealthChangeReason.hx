package minetest.data;

interface PlayerHealthChangeReason {
    @:native("type")
    var type: Reason;
    var object: Null<Any>;
    var from: From;
    var node: Null<Any>;
}

enum abstract From(String) {
    var Mod = "mod";
    var Engine = "engine";
}

enum abstract Reason(String) {
    var SetHp = "set_hp";
    var Punch = "punch";
    var Fall = "fall";
    var NodeDamage = "node_damage";
    var Drown = "drown";
    var Respawn = "respawn";
}
