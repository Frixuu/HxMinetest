package minetest.formspec.element;

@:structInit
final class Button implements FormspecElement {
    public var x: Slot;
    public var y: Slot;
    public var width: Slot;
    public var height: Slot;
    public var name: String;
    public var label: String;

    public inline function new(
        x: Slot, y: Slot, width: Slot, ?height: Slot,
        name: String, label: String
    ) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height ?? new Slot(1.0);
        this.name = name;
        this.label = label;
    }

    public function intoFormspecString(sb: StringBuf) {
        sb.add("button[");
        sb.add(x);
        sb.add(",");
        sb.add(y);
        sb.add(";");
        sb.add(width);
        sb.add(",");
        sb.add(height);
        sb.add(";");
        sb.add(name);
        sb.add(";");
        sb.add(label);
        sb.add("]");
    }
}
