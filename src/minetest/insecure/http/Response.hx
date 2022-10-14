package minetest.insecure.http;

extern class Response {
    @:native("completed")
    public var completed: Bool;
    @:native("succeeded")
    public var succeeded: Bool;
    @:native("timeout")
    public var timedOut: Bool;
    @:native("code")
    public var statusCode: Int;
    @:native("data")
    public var data: String;
}
