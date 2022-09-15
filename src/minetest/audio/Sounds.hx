package minetest.audio;

abstract class Sounds {
    public static inline function play(soundName: String, ?params: SoundParams): SoundHandle {
        params = params != null ? params : new SoundParams();
        return cast Minetest.soundPlay(soundName, params.toNative(), false);
    }

    public static inline function playEphemeral(soundName: String, ?params: SoundParams): Void {
        params = params != null ? params : new SoundParams();
        Minetest.soundPlay(soundName, params.toNative(), true);
    }

    public static inline function stop(handle: SoundHandle) {
        Minetest.soundStop(handle);
    }

    public static inline function fade(handle: SoundHandle, step: Float, gain: Float) {
        Minetest.soundFade(handle, step, gain);
    }
}
