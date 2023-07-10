package minetest.node;

enum abstract DrawType(String) {
    public var Normal = "normal";
    public var Airlike = "airlike";
    public var Liquid = "liquid";
    public var FlowingLiquid = "flowingliquid";
    public var Glasslike = "glasslike";
    public var GlasslikeFramed = "glasslike_framed";
    public var GlasslikeFramedOptional = "glasslike_framed_optional";
    public var AllFaces = "allfaces";
    public var AllFacesOptional = "allfaces_optional";
    public var Torchlike = "torchlike";
    public var Signlike = "signlike";
    public var Plantlike = "plantlike";
    public var PlantlikeRooted = "plantlike_rooted";
    public var Firelike = "firelike";
    public var Fencelike = "fencelike";
    public var Raillike = "raillike";
    public var NodeBox = "nodebox";
    public var Mesh = "mesh";
}
