package minetest.audio;

/**
    A table form of the sound specification.
**/
@:structInit
final class SoundSpecTable {

    /**
        Sound name.
    **/
    @:native("name")
    public var name: String;

    /**
        Sound volume.
    **/
    @:native("gain")
    public var gain: Float = 1.0;

    /**
        Sound pitch.
    **/
    @:native("pitch")
    public var pitch: Float = 1.0;

    /**
        Fade in per second, until `gain` is reached.
        @since Minetest 5.8.0
    **/
    @:native("fade")
    public var fade: Float = 0.0;
}
