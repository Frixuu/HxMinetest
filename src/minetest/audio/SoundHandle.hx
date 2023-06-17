package minetest.audio;

/**
    `SoundHandle` is an opaque handle to some sound that is being played.
**/
abstract SoundHandle(Any) {

    /**
        Stops this sound.
    **/
    public inline function stop() {
        Minetest.soundStop(this);
    }

    /**
        Smoothly tweens this sound's volume towards the target gain.
    **/
    public inline function fade(step: Float, targetGain: Float) {
        Minetest.soundFade(this, step, targetGain);
    }
}
