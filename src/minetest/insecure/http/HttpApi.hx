package minetest.insecure.http;

import minetest.async.Future;

extern final class HttpApi {

    /**
        Performs an HTTP request asynchronously.
    **/
    public inline function fetch(request: Request): Future<Response> {
        final future: Future<Response> = new Future();
        this.fetchRaw(request, response -> future.complete(response));
        return future;
    }

    @:native("fetch")
    @:luaDotMethod
    private function fetchRaw(request: Request, callback: (Response) -> Void): Void;

    @:native("fetch_async")
    @:luaDotMethod
    private function fetchAsyncRaw(request: Request): Dynamic;

    @:native("fetch_async_get")
    @:luaDotMethod
    private function fetchAsyncGetRaw(handle: Any): Response;
}
