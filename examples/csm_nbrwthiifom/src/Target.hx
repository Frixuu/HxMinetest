import minetest.object.ObjectId;

enum Target {
    Nothing;
    Node(node: Dynamic);
    NodeUnknown;
    Object(id: ObjectId);
}
