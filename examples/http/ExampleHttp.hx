import minetest.insecure.http.HttpApi;
import minetest.insecure.http.Request;
import minetest.Minetest;

typedef Quote = {
    var content: String;
    var author: String;
}

function main() {

    final httpApi: Null<HttpApi> = Minetest.requestHttpApi();
    if (httpApi == null) {
        Minetest.log(Error, "Cannot request HTTP API, this example will not work!");
        return;
    }

    final request = Request.GET("https://api.quotable.io/random"); // not affiliated
    request.userAgent = "HxMinetest/Example";
    request.timeout = 5;
    httpApi.fetch(request).thenAccept(response -> {

        if (!response.succeeded) {
            Minetest.log(Error, "HTTP request failed");
            return;
        }

        if (response.statusCode != 200) {
            Minetest.log(Error, 'API responded with code ${response.statusCode}');
            return;
        }

        final body: Quote = cast Minetest.parseJson(response.data);
        if (body == null) {
            Minetest.log(Error, 'Could not parse response body. See logs for details.');
            return;
        }

        Minetest.log('As ${body.author} once said:');
        Minetest.log("\"" + body.content + "\"");
    });
}
