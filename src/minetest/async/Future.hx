package minetest.async;

import haxe.Exception;

class Future<T> {
    var callbacks: Array<(T) -> Void>;
    var state: State<T>;

    public function new() {
        callbacks = [];
        state = Waiting;
    }

    public function thenAccept(callback: (T) -> Void): Void {
        switch state {
            case Ready(result):
                callback(result);
            default:
                callbacks.push(callback);
        }
    }

    public function complete(result: T): Void {
        switch state {
            case Ready(_):
                throw new Exception("This future has already been completed");
            default:
                state = Ready(result);
                for (callback in callbacks) {
                    callback(result);
                }
        }
    }
}

enum State<T> {
    Waiting;
    Ready(result: T);
}
