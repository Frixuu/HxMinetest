package minetest.formspec.element;

@:structInit
final class Label implements FormspecElement {
    public var x: Slot;
    public var y: Slot;
    public var text: String;

    public inline function new(x: Slot, y: Slot, text: String) {
        this.x = x;
        this.y = y;
        this.text = Minetest.formspecEscape(text);
    }

    public function intoFormspecString(sb: StringBuf) {
        sb.add("label[");
        sb.add(x);
        sb.add(",");
        sb.add(y);
        sb.add(";");
        sb.add(text);
        sb.add("]");
    }
}
