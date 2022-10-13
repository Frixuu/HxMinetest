package minetest.client;

#if csm
interface ServerInfo {

    /**
        The domain name/IP address of a remote server
        or an empty string for a local server.
    **/
    @:native("address")
    var address: String;

    /**
        The IP address of the server.
    **/
    @:native("ip")
    var ip: String;

    /**
        The port the client is connected to.
    **/
    @:native("port")
    var port: Int;

    /**
        The protocol version of the server.

        NOTE: Might be 0 at start up.
    **/
    @:native("protocol_version")
    var protocolVersion: Int;
}
#end
