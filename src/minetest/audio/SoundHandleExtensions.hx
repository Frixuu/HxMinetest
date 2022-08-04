package minetest.audio;

class SoundHandleExtensions {
    /**
        If this handle refers to a sound that is currently playing,
        stops that sound.
    **/
    public static inline function stop(handle: SoundHandle): Void {
        Sounds.stop(handle);
    }
}
