package minetest.text;

/**
	A mutable chunk of text and its decorations,
	forming a whole text message.
**/
class Component {
	private var content(default, null):String;
	private var colorText(default, null):Null<String>;
	private var children(default, null):Array<Component>;

	private function new(content:String) {
		this.content = content;
		this.colorText = null;
		this.children = new Array();
	}

	/**
		Creates a new `Component` with provided text contents.
	**/
	public static inline function text(content:String) {
		return new Component(content);
	}

	/**
		Sets this `Component`'s text color.
	**/
	public inline function color(textColor:String):Component {
		this.colorText = textColor;
		return this;
	}

	/**
		Adds another `Component` as a child of this `Component`.
		When building to a string, children will be rendered after their parents.

		NOTE: This API does not check for cyclic dependencies. Beware.
	**/
	public inline function append(child:Component):Component {
		this.children.push(child);
		return this;
	}

	private function buildNode(buffer:StringBuf):Void {
		if (this.colorText == null) {
			buffer.add(this.content);
		} else {
			buffer.add(Escape.colorize(this.colorText, this.content));
		}
		for (child in this.children) {
			child.buildNode(buffer);
		}
	}

	/**
		Builds this `Component` to a string used in e.g. chat messages.
	**/
	public function build():String {
		final message = new StringBuf();
		this.buildNode(message);
		return message.toString();
	}
}