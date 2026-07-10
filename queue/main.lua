-- Dynamic queue
-- this plugin will automatically adjust player slots to prevent server crash when too many players connect at once after restart

-- these values are fine-tuned to what works best on Avardon, on your own server you will want to monitor how the server behaves and adjust
local MEMORY_HIGH = 21      -- GB of RAM after which the server struggles, careful mode is enabled
local MEMORY_LOW = 13       -- GB of RAM under which the server experiences basically no load and runs perfectly smooth
local MAX_SLOTS = 200       -- maximum of player slots you don't want to go beyond
local SLOTS_ADD_CAREFUL = 3 -- how many players can connect at once during careful mode
local SLOTS_ADD_NORMAL = 4  -- how many players can usually connect at once (RAM between low and high)
local SLOTS_ADD_EXTRA = 8   -- how many players can connect at once when the server runs perfectly smooth
local SLOTS_TOLERANCE = 2   -- by how many players does the count need to change before we bother adjusting slots, has to be lower than the numbers above (this is ignored in careful mode)
local REFRESH_SECONDS = 20  -- amount of seconds between each refresh of slots

-- do not change the code beyond this line unless you know what you're doing
local slots = 0

function adjustQueue()
    local playerCount = getPlayerCount()
    local memory = Server.GetMemoryUsage() / 1024 / 1024 / 1024

    local pad, diff = SLOTS_ADD_NORMAL, SLOTS_TOLERANCE
    if (memory > MEMORY_HIGH) then
        pad, diff = SLOTS_ADD_CAREFUL, 0
    elseif (memory < MEMORY_LOW) then
        pad, diff = SLOTS_ADD_EXTRA, SLOTS_TOLERANCE
    end

    local target = math.min(playerCount + pad, MAX_SLOTS)
    if (target < slots - diff or target > slots + diff) then
        slots = target
        Server.SetMaxPlayers(slots)
        printDebug(("Slots adjusted: %s/%s | Memory: %s"):format(playerCount, slots, memory))
    end
end
setTimer(adjustQueue, REFRESH_SECONDS * 1000, 0)
