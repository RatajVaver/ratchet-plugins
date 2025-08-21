-- this example shows how vectors can be used

function measureDistanceBetweenPlayers(player, targets, args)
    local target = targets[1]
    local pos1 = player:GetPosition()
    local pos2 = target:GetPosition()
    local distance = pos1:getDistanceTo(pos2)
    distance = distance / 256 -- convert to tiles
    TotChat.NotifyLocal(player, string.format("%s is distanced %.1f tiles.", target:GetName(), distance))
end
on("vector_playersDistance", measureDistanceBetweenPlayers)

local a = Vector(3,2,1)
local b = Vector(1,2,3)
print(b:length())
local c = a + b
print(c:length())