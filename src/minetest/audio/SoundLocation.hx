package minetest.audio;

import minetest.data.ObjectRef;
import minetest.math.Vector;

/**
    Describes where the played sound can be heard from.
**/
enum SoundLocation {

    /**
        The sound does not have a clear origin.
    **/
    Global;

    /**
        The sound is being played at a specific world position.
    **/
    AtPosition(pos: Vector);

    /**
        The sound location is bound to a specific object.
    **/
    ObjectBound(object: ObjectRef);
}
