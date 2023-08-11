import minetest.util.NativeSet;

using Lambda;
using StringTools;

final class TextTools {
    private static var ignoreWords: NativeSet<String>;
    private static var knownMods: Map<String, String>;

    private static function __init__() {
        ignoreWords = ["a", "an", "the", "with", "in", "on", "without"];
        knownMods = ["default" => "Minetest Game"];
    }

    /**
        Converts a snake_case string by splitting its words
        and making each start with an uppercase letter.
    **/
    public static function snakeCaseToPascalCase(text: String) {
        return text.split("_")
            .map(word -> if (ignoreWords.has(word)) {
                word;
            } else {
                word.charAt(0).toUpperCase() + word.substr(1);
            })
            .join(" ");
    }

    public static function formatAsModName(modName: String): String {
        final knownName = knownMods.get(modName);
        if (knownName != null) {
            return knownName;
        }
        return snakeCaseToPascalCase(modName);
    }
}
