-- Script security manager forces us to do this call only when we're not in a function
-- See https://github.com/minetest/minetest/blob/8f25f487/src/script/cpp_api/s_security.cpp#L635
__hxminetest.http_api = minetest and minetest.request_http_api and minetest.request_http_api()
