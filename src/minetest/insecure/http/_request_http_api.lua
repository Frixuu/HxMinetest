-- Script security manager forces us to do this call only when we're not in a function
-- See https://github.com/minetest/minetest/blob/be05c9022d/src/script/cpp_api/s_security.cpp#L612
local __hxminetest_http_api = _G.minetest and _G.minetest.request_http_api and _G.minetest.request_http_api()
