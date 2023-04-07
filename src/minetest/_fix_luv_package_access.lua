-- Works around an attempt at indexing a nil field when setting up main loop
-- (we will not use it anyway)
if not _G.package then
  _G.package = { loaded = {} }
elseif not _G.package.loaded then
  _G.package.loaded = {}
end
