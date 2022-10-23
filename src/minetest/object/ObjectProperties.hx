package minetest.object;

class ObjectProperties {
    @:native("hp_max")
    public var hpMax: Null<Int>;

    @:native("breath_max")
    public var breathMax: Null<Int>;

    @:native("zoom_fov")
    public var zoomFov: Null<Float>;

    @:native("physical")
    public var physical: Null<Bool>;

    @:native("collide_with_objects")
    public var collideWithObjects: Null<Bool>;

    @:native("pointable")
    public var pointable: Null<Bool>;

    @:native("mesh")
    public var mesh: Null<String>;
}
