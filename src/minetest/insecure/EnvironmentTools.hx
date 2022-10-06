package minetest.insecure;

import haxe.Exception;

class EnvironmentTools {

    /**
        Runs a function using the provided environment.

        Source: https://github.com/minetest/minetest/issues/10877#issuecomment-1060033815
        @author DS
    **/
    public static function run<T, R>(env: InsecureEnvironment, state: T, func: (T) -> R): R {
        env.debug.sethook();

        final old_fenv = env.getfenv(0);
        final old_string_mt = env.debug.getmetatable("");

        env.setfenv(0, env);
        env.debug.setmetatable("", {__index: env.string});

        final result = env.pcall(func, state);

        env.setfenv(0, old_fenv);
        env.debug.setmetatable("", old_string_mt);

        if (!result.status) {
            throw new Exception('Could not run: ${result.value}');
        }

        return cast result.value;
    }
}
