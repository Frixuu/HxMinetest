final class Game {
    public var target: Int;
    public var guessCount: Int;
    public var ended: Bool;

    public function new(?target: Int) {
        this.target = target ?? cast lua.Math.random(100);
        this.guessCount = 0;
        this.ended = false;
    }

    public function submitGuess(guess: Int): GuessResult {
        if (this.ended) {
            return AlreadyEnded;
        }

        this.guessCount += 1;

        if (guess == target) {
            this.ended = true;
            return Exact;
        }

        return (guess < target) ? TooLow : TooHigh;
    }
}

enum GuessResult {
    AlreadyEnded;
    TooLow;
    TooHigh;
    Exact;
}
