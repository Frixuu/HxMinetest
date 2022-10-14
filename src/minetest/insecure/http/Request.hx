package minetest.insecure.http;

import haxe.extern.EitherType;
import haxe.http.HttpMethod;
import lua.Table;

class Request {
    @:native("url")
    public var url: String;

    @:native("timeout")
    public var timeout: Int;

    @:native("data")
    public var data: Null<EitherType<String, Table<String, Any>>>;

    @:native("method")
    public var method: HttpMethod;

    @:native("user_agent")
    public var userAgent: Null<String>;

    @:native("extra_headers")
    public var headers: Null<Table<Int, String>>;

    @:native("multipart")
    public var multipart: Bool;

    public function new(
        url: String,
        ?method: HttpMethod = HttpMethod.Get,
        ?timeout: Int = 10,
        ?multipart: Bool = false,
        ?data: EitherType<String, Table<String, Any>> = null,
        ?headers: Table<Int, String> = null,
        ?userAgent: String = null
    ) {
        this.url = url;
        this.method = method;
        this.timeout = timeout;
        this.multipart = multipart;
        this.data = data;
        this.headers = headers;
        this.userAgent = userAgent;
    }

    public static inline function GET(url: String): Request {
        return new Request(url, HttpMethod.Get);
    }
}
