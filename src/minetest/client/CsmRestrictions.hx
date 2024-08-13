package minetest.client;

#if hxminetest._clientside
enum abstract CsmRestrictions(String) {
    public var LoadClientMods = "load_client_mods";
    public var ChatMessages = "chat_messages";
    public var ReadItemDefinitions = "read_itemdefs";
    public var ReadNodeDefinitions = "read_nodedefs";
    public var LookupNodes = "lookup_nodes";
    public var ReadPlayerInfo = "read_playerinfo";
}
#end
