package minetest;

import minetest.data.ObjectRef;
import minetest.math.Vector;
import minetest.object.ObjectId;

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
    #if hxminetest._clientside
    @:native("id")
    public var objectId: ObjectId;
    #else
    @:native("ref")
    public var objectRef: ObjectRef;
    #end
}
