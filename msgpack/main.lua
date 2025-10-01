-- This example showcases the compatibility with LuaRocks.
-- Specifically MessagePack and inspect modules are shown here.
-- They need to be installed for this example to work.

-- You might need to specify package path like this, or set 'packages' in Ratchet config.
-- package.path = package.path .. ";C:/Users/USERNAME/AppData/Roaming/luarocks/share/lua/5.4/?.lua"

local mp = require 'MessagePack'
local inspect = require 'inspect'

local data = {
    msg = "Hello world",
    pi = math.pi
}

local packed = mp.pack(data)

local file = io.open("ratchet/data/test.msgpack", "w")
file:write(packed)
file:close()

local file = io.open("ratchet/data/test.msgpack", "r")
local packed = file:read()
file:close()

local unpacked = mp.unpack(packed)
printInfo("Data:\n", inspect(unpacked))