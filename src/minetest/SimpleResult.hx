package minetest;

enum abstract SimpleResult(Null<Bool>) {
    public var Ok = true;
    public var Error = null;

    @:to
    private function toBool(): Bool {
        return this == true;
    }
}
