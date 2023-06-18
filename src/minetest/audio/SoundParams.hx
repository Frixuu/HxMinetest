package minetest.audio;

import minetest.math.Vector;
import minetest.data.ObjectRef;

/**
    Additional sound parameters.
**/
@:structInit
class SoundParams {

    /**
        Scales the gain specified in the `SoundSpec`, if one set.
    **/
    @:native("gain")
    public var gain: Null<Float>;

    /**
        Fade of the sound. Overrides one set in `SoundSpec`, if one provided.
    **/
    @:native("fade")
    public var fade: Null<Float>;

    /**
        Pitch of the sound. Overrides one set in `SoundSpec`, if one provided.
    **/
    @:native("pitch")
    public var pitch: Null<Float>;

    /**
        If true, the sound will be played in a loop.
    **/
    @:native("loop")
    public var loop: Null<Bool>;

    /**
        If set to a positive number, starts playing X seconds into the sound.
        If negative, starts playing X seconds before the end of the sound.
        @since Minetest 5.8.0
    **/
    @:native("start_time")
    public var startOffset: Null<Float>;

    @:native("pos")
    private var pos: Null<Vector>;

    @:native("object")
    private var object: Null<ObjectRef>;

    /**
        The location of the sound.
    **/
    public var location(get, set): SoundLocation;

    private function get_location(): SoundLocation {
        return switch [this.object, this.pos] {
            case [null, null]: Global;
            case [null, pos]: AtPosition(pos);
            case [object, null]: ObjectBound(object);
            case _: throw "Sound parameter table is in an invalid state (bad location)";
        }
    }

    private function set_location(value: SoundLocation): SoundLocation {
        final old = this.location;
        switch (value) {
            case Global:
                this.pos = null;
                this.object = null;
            case AtPosition(pos):
                this.pos = pos;
                this.object = null;
            case ObjectBound(object):
                this.pos = null;
                this.object = object;
        }
        return old;
    }

    @:native("to_player")
    private var toPlayer: Null<String>;

    @:native("exclude_player")
    private var excludePlayer: Null<String>;

    /**
        Players who will be able to hear this sound.
    **/
    public var audience(get, set): SoundAudience;

    private function get_audience(): SoundAudience {
        return switch [this.toPlayer, this.excludePlayer] {
            case [null, null]: AllPlayers;
            case [target, null]: OnePlayer(target);
            case [null, except]: EveryoneBut(except);
            case _: throw "Sound parameter table is in an invalid state (bad audience)";
        }
    }

    private function set_audience(value: SoundAudience): SoundAudience {
        final old = this.audience;
        switch (value) {
            case AllPlayers:
                this.toPlayer = null;
                this.excludePlayer = null;
            case OnePlayer(playerName):
                this.toPlayer = playerName;
                this.excludePlayer = null;
            case EveryoneBut(playerName):
                this.toPlayer = null;
                this.excludePlayer = playerName;
        }
        return old;
    }

    /**
        Cuts off the sound for players
        that are initially that many blocks away from the sound's position.
        Does not work when `location` is set to `Global`.
    **/
    @:native("max_hear_distance")
    public var maxDistance: Null<Float>;

    /**
        Creates a new sound parameter table.
    **/
    @:dox(hide)
    public function new(
        ?gain: Float = 1.0,
        ?pitch: Float,
        ?fade: Float,
        ?loop: Bool = false,
        ?maxDistance: Float = 32.0,
        ?startOffset: Float = 0.0,
        ?location: SoundLocation,
        ?audience: SoundAudience
    ) {
        this.gain = gain;
        this.pitch = pitch;
        this.fade = fade;
        this.loop = loop;
        this.maxDistance = maxDistance;
        this.startOffset = startOffset;

        if (location != null) {
            this.location = location;
        }

        if (audience != null) {
            this.audience = audience;
        }
    }
}
