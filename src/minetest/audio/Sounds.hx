package minetest.audio;

import haxe.extern.EitherType;
import minetest.audio.SoundParams.NativeSoundParams;

abstract class Sounds {
    public static inline function play(soundName: String, ?params: SoundParams): SoundHandle {
        params = params != null ? params : new SoundParams();
        return cast Extern.playSound(soundName, params.toNative(), false);
    }

    public static inline function playEphemeral(soundName: String, ?params: SoundParams): Void {
        params = params != null ? params : new SoundParams();
        Extern.playSound(soundName, params.toNative(), true);
    }

    public static inline function stop(handle: SoundHandle) {
        Extern.stopSound(handle);
    }

    public static inline function fade(handle: SoundHandle, step: Float, gain: Float) {
        Extern.fadeSound(handle, step, gain);
    }
}

@:native("minetest")
private extern interface Extern {
    @:native("sound_play")
    static function playSound(spec: Any,
        parameters: NativeSoundParams,
        ephemeral: Bool = false): EitherType<Void, SoundHandle>;

    @:native("sound_stop")
    static function stopSound(handle: SoundHandle): Void;

    @:native("sound_fade")
    static function fadeSound(handle: SoundHandle, step: Float, gain: Float): Void;
}
