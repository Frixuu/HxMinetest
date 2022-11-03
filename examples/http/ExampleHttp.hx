import minetest.insecure.http.HttpApi;
import minetest.insecure.http.Request;
import minetest.Minetest;

typedef Quote = {
    var anime: String;
    var character: String;
    var quote: String;
}

class ExampleHttp {
    private static function main() {

        final httpApi: Null<HttpApi> = Minetest.requestHttpApi();
        if (httpApi == null) {
            Minetest.log(Error, "Cannot request HTTP API, this example will not work!");
            return;
        }

        final request = Request.GET("https://animechan.vercel.app/api/random"); // not affiliated
        request.userAgent = "HxMinetest/Example";
        request.timeout = 5;
        httpApi.fetch(request)
            .thenAccept(response -> {
                if (response.succeeded) {
                    try {
                        final body: Quote = cast Minetest.parseJson(response.data);
                        Minetest.log(Action, 'As ${body.character} from ${body.anime} once said:');
                        Minetest.log(Action, body.quote);
                    } catch (e:Dynamic) {
                        Minetest.log(Error, 'Could not parse response body: $e');
                    }
                } else {
                    Minetest.log(Warning, "HTTP request failed");
                }
            });
    }
}
