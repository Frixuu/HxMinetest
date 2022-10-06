package minetest.audio;

import minetest.math.Vector;
import minetest.data.ObjectRef;

class SoundParams {
    private var _gain: Float = 1.0;
    private var _fade: Float = 0.0;
    private var _pitch: Float = 1.0;
    private var _loop: Bool = false;
    private var _audience: Audience = Audience.AllPlayers;
    private var _location: Location = Location.Global;

    /** Uses Euclidean metric. **/
    private var _maxDistance: Float = 32.0;

    public function new() {}

    public inline function gain(value: Float): SoundParams {
        this._gain = value;
        return this;
    }

    public inline function fade(value: Float): SoundParams {
        this._fade = value;
        return this;
    }

    public inline function pitch(value: Float): SoundParams {
        this._pitch = value;
        return this;
    }

    public inline function loop(value: Bool): SoundParams {
        this._loop = value;
        return this;
    }

    public inline function maxDistance(value: Float): SoundParams {
        this._maxDistance = value;
        return this;
    }

    public inline function audience(value: Audience): SoundParams {
        this._audience = value;
        return this;
    }

    public inline function location(value: Location): SoundParams {
        this._location = value;
        return this;
    }

    @:allow(minetest.data.PlayerTools)
    private function toNative(): NativeSoundParams {
        final params: NativeSoundParams = {};
        if (_gain != 1.0) {
            params.gain = _gain;
        }
        if (_fade != 0.0) {
            params.fade = _fade;
        }
        if (_pitch != 1.0) {
            params.pitch = _pitch;
        }
        if (_loop) {
            params.loop = true;
        }
        if (_maxDistance != 32.0) {
            params.max_hear_distance = _maxDistance;
        }
        switch (_audience) {
            case OnePlayer(playerName):
                params.to_player = playerName;
            case EveryoneBut(playerName):
                params.exclude_player = playerName;
            case AllPlayers:
        }

        switch (_location) {
            case AtPosition(pos):
                params.pos = pos;
            case ObjectBound(object):
                params.object = object;
            case Global:
        }
        return params;
    }
}

/** Describes where the played sound can be heard from. **/
enum Location {

    /** The sound is locationless. **/
    Global;

    /** Positional.**/
    AtPosition(pos: Vector);

    /** The sound location is bound to a specific object. **/
    ObjectBound(object: ObjectRef);
}

/** The target audience for the sound being played. **/
enum Audience {

    /** The sound should play on all clients. **/
    AllPlayers;

    /** The sound should play only for a single player. **/
    OnePlayer(playerName: String);

    /** The sound should be heard by anyone except the given player. **/
    EveryoneBut(playerName: String);
}

/**
    Sound parameter table that is used in the raw `minetest.sound_play` call.
**/
typedef NativeSoundParams = {
    @:optional var gain: Float;
    @:optional var fade: Float;
    @:optional var pitch: Float;
    @:optional var loop: Bool;
    @:optional var to_player: String;
    @:optional var exclude_player: String;
    @:optional var pos: {x: Float, y: Float, z: Float};
    @:optional var max_hear_distance: Float;
    @:optional var object: ObjectRef;
}
