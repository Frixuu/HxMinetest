package minetest.audio;

class SoundHandleExtensions {
    public static inline function stopPlaying(handle: SoundHandle): Void {
        Sounds.stop(handle);
    }
}
