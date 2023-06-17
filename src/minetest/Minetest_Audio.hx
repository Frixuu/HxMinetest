package minetest;

import partials.Partial;

@:noCompletion
extern class Minetest_Audio implements Partial {

    /**
        Plays a sound.
    **/
    @:native("sound_play")
    @:overload(function(spec: SoundSpec, parameters: SoundParams): Void {})
    @:overload(function(spec: SoundSpec, parameters: SoundParams, ephemeral: Bool): SoundHandle {})
    public static function soundPlay(
        spec: SoundSpec,
        parameters: SoundParams,
        ?ephemeral: Bool = false
    ): Null<SoundHandle>;

    /**
        Stops a playing sound.
        @param handle The handle to the sound being played.
    **/
    @:native("sound_stop")
    public static function soundStop(handle: SoundHandle): Void;

    /**
        Smoothly fades a provided sound to the target volume.
        @param handle The handle to the sound being played.
        @param step The delta of the gain per second.
        @param targetGain The target volume of the sound. Fading to 0 will delete the sound.
    **/
    @:native("sound_fade")
    public static function soundFade(handle: SoundHandle, step: Float, targetGain: Float): Void;
}
