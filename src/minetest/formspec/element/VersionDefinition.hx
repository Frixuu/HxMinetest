package minetest.formspec.element;

@:structInit
final class VersionDefinition implements FormspecElement {
    public var version: Int;

    public inline function new(version: Int = 1) {
        this.version = version;
    }

    public function intoFormspecString(sb: StringBuf) {
        sb.add("formspec_version[");
        sb.add(version);
        sb.add("]");
    }
}
