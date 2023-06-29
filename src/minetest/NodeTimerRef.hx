package minetest;

@:remove
interface NodeTimerRef {

    /**
        The current elapsed time, in seconds.
    **/
    public var elapsed(get, never): Float;
    @:native("get_elapsed") private function get_elapsed(): Float;

    /**
        The current timeout, in seconds.
    **/
    public var timeout(get, never): Float;
    @:native("get_timeout") private function get_timeout(): Float;

    /**
        Sets a timer's state.
    **/
    @:native("set")
    public function set(timeout: Float, elapsed: Float): Void;

    /**
        Starts a timer. (Equivalent to `set`(timeout, 0))
    **/
    @:native("start")
    public function start(timeout: Float): Void;

    /**
        Stops the timer.
    **/
    @:native("stop")
    public function stop(): Void;

    /**
        Returns true if the timer is started.
    **/
    @:native("is_started")
    public function isStarted(): Bool;
}
