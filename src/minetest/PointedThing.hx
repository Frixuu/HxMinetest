package minetest;

import minetest.object.ObjectId;
import minetest.math.Vector;
import minetest.data.ObjectRef;

interface PointedThing extends Node extends Object {
    @:native("type")
    public var type: Type;
}

enum abstract Type(String) {
    public var Nothing = "nothing";
    public var Node = "node";
    public var Object = "object";
}

interface Node {
    @:native("under")
    public var under: Vector<Int>;
    @:native("above")
    public var above: Vector<Int>;
}

interface Object {
    #if csm
    @:native("id")
    public var objectId: ObjectId;
    #else
    @:native("ref")
    public var objectRef: ObjectRef;
    #end
}
