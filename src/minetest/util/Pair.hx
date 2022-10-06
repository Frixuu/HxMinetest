package minetest.util;

import haxe.extern.EitherType;
import minetest.util.Tuple;

abstract Pair<L, R>(Tuple<EitherType<L, R>>) {
    public var left(get, never): L;

    private inline function get_left(): L
        return this.get(0);

    public var right(get, never): R;

    private inline function get_right(): R
        return this.get(1);

    public inline function new(left: L, right: R) {
        this = new Tuple<EitherType<L, R>>(left, right);
    }
}
