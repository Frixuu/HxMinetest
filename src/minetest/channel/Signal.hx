package minetest.channel;

enum abstract Signal(Int) {

    /**
        The server has acknowledged our channel join.
    **/
    public var JoinOk = 0;

    /**
        The server refused our channel join,
        typically because it has already been registered.
    **/
    public var JoinFailed = 1;

    /**
        The server acknowledged our channel leave.
    **/
    public var LeaveOk = 2;

    /**
        The server refused our channel leave,
        typically because we did not join the channel in the first place.
    **/
    public var LeaveFailed = 3;

    /**
        The server claims we have sent a message on an unregistered channel.
        This should not happen and probably indicates an engine bug.
    **/
    public var MessageOnUnregisteredChannel = 4;

    /**
        The channel state changed.
        Typical change could be e.g. to enable or disable a read-only mode.
    **/
    public var StateChanged = 5;
}
