package minetest.formspec.element;

@:structInit
final class Size implements FormspecElement {
    public var width: Slot;
    public var height: Slot;
    public var fixedSize: Null<Bool>;

    public inline function new(width: Slot, height: Slot, ?fixedSize: Bool) {
        this.width = width;
        this.height = height;
        this.fixedSize = fixedSize;
    }

    public inline function intoFormspecString(sb: StringBuf) {
        sb.add("size[");
        sb.add(this.width);
        sb.add(",");
        sb.add(this.height);
        if (this.fixedSize != null) {
            sb.add(",");
            sb.add(this.fixedSize);
        }
        sb.add("]");
    }
}
