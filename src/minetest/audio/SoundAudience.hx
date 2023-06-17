package minetest.audio;

/**
    The target audience for the sound being played.
**/
enum SoundAudience {

    /**
        The sound should play on all clients.
    **/
    AllPlayers;

    /**
        The sound should play for a single player only.
    **/
    OnePlayer(playerName: String);

    /**
        The sound should be heard by anyone except the given player.
    **/
    EveryoneBut(playerName: String);
}
