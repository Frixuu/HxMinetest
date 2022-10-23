package minetest.privilege;

final class PrivilegeDefinition {
    @:native("give_to_singleplayer")
    public var giveToSingleplayer: Bool;

    @:native("give_to_admin")
    public var giveToAdmin: Bool;

    @:native("description")
    public var description: String;

    @:native("on_grant")
    public var onGrant: Null<(name: String, granterName: Null<String>) -> Bool>;

    @:native("on_revoke")
    public var onRevoke: Null<(name: String, revokerName: Null<String>) -> Bool>;

    public function new(
        description: String,
        giveToSingleplayer: Bool = true,
        giveToAdmin: Bool = true
    ) {
        this.description = description;
        this.giveToSingleplayer = giveToSingleplayer;
        this.giveToAdmin = giveToAdmin;
    }
}
