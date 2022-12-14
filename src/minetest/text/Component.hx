package minetest.text;

import minetest.colors.ColorString;
import minetest.colors.Color;

typedef TranslatableComponentPartial = (text: String, ...args: Any) -> Component;

/**
    A mutable chunk of text and its decorations,
    forming a whole text message.
**/
class Component {
    private var content(default, null): String;
    private var colorText(default, null): Null<ColorString>;
    private var children(default, null): Array<Component>;

    private function new(content: String) {
        this.content = content;
        this.colorText = null;
        this.children = new Array();
    }

    /**
        Creates a new `Component` with provided text contents.
    **/
    public static inline function text(content: String): Component {
        return new Component(content);
    }

    /**
        Returns a function that creates client-side translatable `Component`s.

        This is similar to Minetest's idiom of `local S = minetest.get_translator()`.

        Usage:
        ```
        final tr = Component.getTranslator("mymod");
        player.sendChatMessage(tr("This is very cool!")
            .color(Color.rgb(255, 132, 87))
            .build());
        ```
    **/
    public static inline function getTranslator(domain: String): TranslatableComponentPartial {
        // translate.bind(domain) had a weird codegen issue
        // where a table.unpack operation created arguments that did not exist
        return function(text: String, ...args: Any): Component {
            return Component.translate(domain, text, ...args);
        };
    }

    /**
        Creates a new `Component` with a client-side translatable text content.
    **/
    public static inline function translate(domain: String, text: String, ...args: Any) {
        return new Component(Minetest.translate(domain, text, ...args));
    }

    /**
        Sets this `Component`'s text color.
    **/
    public inline function color(textColor: Color): Component {
        return this.colorStr(textColor);
    }

    /**
        Sets this `Component`'s text color.
    **/
    public inline function colorStr(textColor: ColorString): Component {
        this.colorText = textColor;
        return this;
    }

    /**
        Adds another `Component` as a child of this `Component`.
        When building to a string, children will be rendered after their parents.

        NOTE: This API does not check for cyclic dependencies. Beware.
    **/
    public inline function append(child: Component): Component {
        this.children.push(child);
        return this;
    }

    /**
        Pushes this node's contents to the buffer,
        and then does the same with it's children.
    **/
    private function buildSubtree(buffer: StringBuf): Void {
        if (this.colorText == null) {
            buffer.add(this.content);
        } else {
            buffer.add(Minetest.colorize(this.colorText, this.content));
        }
        for (child in this.children) {
            child.buildSubtree(buffer);
        }
    }

    /**
        Builds this `Component` to a string used in e.g. chat messages.
    **/
    public function build(): String {
        final message = new StringBuf();
        this.buildSubtree(message);
        return message.toString();
    }
}
