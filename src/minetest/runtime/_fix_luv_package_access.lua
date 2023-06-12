-- WORKAROUND: While attempting to set up a main loop,
-- Haxe 4.3 tries to detect if libuv is available
-- in a way that Minetest's environment is not prepared for
if not _G.package then
  _G.package = { loaded = {} }
elseif not _G.package.loaded then
  _G.package.loaded = {}
end
