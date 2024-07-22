package minetest.formspec.element;

@:structInit
final class Field implements FormspecElement {
    public var x: Slot;
    public var y: Slot;
    public var width: Slot;
    public var height: Slot;
    public var name: String;
    public var label: Null<String>;
    public var defaultValue: Null<String>;

    public inline function new(
        x: Slot, y: Slot, width: Slot, ?height: Slot,
        name: String, ?label: String, ?defaultValue: String
    ) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height ?? new Slot(1.0);
        this.name = name;
        this.label = label;
        this.defaultValue = defaultValue;
    }

    public function intoFormspecString(sb: StringBuf) {
        sb.add("field[");
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
        sb.add(label ?? "");
        sb.add(";");
        sb.add(defaultValue ?? "");
        sb.add("]");
    }
}
