import minetest.Minetest;
import minetest.formspec.Formspec;
import minetest.formspec.Formspec.*;
import minetest.formspec.FormspecString;

using minetest.formspec.UnitTools;

inline final FORM_NAME: String = "formspec_guessing_game:game";
final gamesInProgress: Map<String, Game> = [];

function resumeGame(playerName: String) {
    var game = gamesInProgress.get(playerName);
    if (game == null) {
        game = new Game();
        gamesInProgress.set(playerName, game);
    }

    Minetest.showFormspec(playerName, FORM_NAME, buildFormspec(game, null));
}

function buildFormspec(game: Game, ?lastGuess: Game.GuessResult): FormspecString {
    // @formatter:off
    return Formspec.v4([
        size({ width: 400.px(), height: 240.px() }),
        label({ x: 24.px(), y: 32.px(), text: switch (lastGuess) {
                case null:
                    "I'm thinking of a number... Make a guess!";
                case AlreadyEnded:
                    "The game has already ended! Run /game to start a new game.";
                case Exact:
                    'Hooray! You got it in ${game.guessCount} guesses!';
                case TooLow:
                    "Too low!";
                case TooHigh:
                    "Too high!";
            }
        }),
        field({ label: "Your number:", x: 24.px(), y: 80.px(), width: 352.px(), height: 0.8, name: "number" }),
        button({ label: "Guess", x: 100.px(), y: 160.px(), width: 200.px(), height: 0.8, name: "guess" })
    ]);
    // @formatter:on
}

function main() {

    // Running /game command should start a new game for that player
    Minetest.registerChatCommand("game", {
        handler: (playerName, _) -> {
            resumeGame(playerName);
            return true;
        }
    });

    Minetest.registerOnPlayerReceiveFields((player, formName, fields) -> {
        if (formName == FORM_NAME && fields.exists("guess")) {

            final name = player.getPlayerName();
            final game = gamesInProgress.get(name);
            if (game == null) {
                player.sendChatMessage("You are not in a game right now!");
                return;
            }

            final guessedNumber = Std.parseInt(fields.get("number"));
            if (guessedNumber == null) {
                player.sendChatMessage("Please enter a valid integer.");
                return;
            }
            if (guessedNumber < 0) {
                player.sendChatMessage("Please enter a positive integer.");
                return;
            }

            final result = game.submitGuess(guessedNumber);
            if (result == Exact) {
                gamesInProgress.remove(name);
            }

            Minetest.showFormspec(name, FORM_NAME, buildFormspec(game, result));
        }
    });

    // When the player leaves, the game should stop
    Minetest.registerOnPlayerLeave((player, _) -> {
        gamesInProgress.remove(player.getPlayerName());
    });
}
