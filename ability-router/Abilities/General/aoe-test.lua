local Ability = {}

function Ability:Run(player, targets)
    local pos = player:GetPosition()
    targets = getPlayersInRadius(pos, 3)

    TotChat.SendLocal(player, player:GetName() .. " casts AoE, affecting everyone within 3 tiles radius.", 20)
    for _,v in ipairs(targets)do
        if(v ~= player)then -- ignore the caster
            local distance = v:GetPosition():getDistanceTo(pos) / 256
            TotChat.SendLocal(v, ("%s is in the AoE range, distanced %.1f tiles from the caster."):format(v:GetName(), distance), 20)
        end
    end
end

return Ability