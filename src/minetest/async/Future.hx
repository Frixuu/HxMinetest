package minetest.async;

import haxe.ds.Vector;
import minetest.util.Nothing;
import haxe.Exception;

class Future<T> {
    private var callbacks: Array<(T) -> Void>;

    public var state(default, null): State<T>;

    public function new() {
        callbacks = [];
        state = Waiting;
    }

    public function thenAccept(callback: (T) -> Void): Future<Nothing> {
        return switch state {
            case Ready(result):
                callback(result);
                final future = new Future<Nothing>();
                future.complete(Nothing);
                future;
            default:
                final future = new Future<Nothing>();
                callbacks.push(result -> {
                    callback(result);
                    future.complete(Nothing);
                });
                future;
        }
    }

    public function thenApply<U>(callback: (T) -> U): Future<U> {
        return switch state {
            case Ready(result):
                final future = new Future<U>();
                future.complete(callback(result));
                future;
            default:
                final future = new Future<U>();
                callbacks.push(result -> {
                    future.complete(callback(result));
                });
                future;
        }
    }

    public function thenRun(action: () -> Void): Future<Nothing> {
        return switch state {
            case Ready(_):
                action();
                final future = new Future<Nothing>();
                future.complete(Nothing);
                future;
            default:
                final future = new Future<Nothing>();
                callbacks.push(_ -> {
                    action();
                    future.complete(Nothing);
                });
                future;
        }
    }

    public function completeIfWaiting(result: T): Bool {
        return switch state {
            case Waiting:
                this.state = Ready(result);
                for (callback in this.callbacks) {
                    callback(result);
                }
                true;
            default:
                false;
        }
    }

    public function complete(result: T): Void {
        if (!completeIfWaiting(result)) {
            throw new Exception("This future has already been completed");
        }
    }

    public static function anyOf<T>(futures: Array<Future<T>>): Future<T> {
        final futureAny = new Future<T>();
        for (future in futures) {
            future.thenAccept(result -> futureAny.completeIfWaiting(result));
        }
        return futureAny;
    }

    public static function allOf<T>(futures: Array<Future<T>>): Future<Array<T>> {
        final futures = futures.copy();
        final results: Array<T> = [];
        final futureAll = new Future<Array<T>>();
        final remainingBoxed = [futures.length];
        for (i => future in futures) {
            future.thenAccept(result -> {
                final remaining = remainingBoxed[0] - 1;
                remainingBoxed[0] = remaining;
                results[i] = result;
                if (remaining == 0) {
                    futureAll.complete(results);
                }
            });
        }
        return futureAll;
    }
}

enum State<T> {
    Waiting;
    Ready(result: T);
}
