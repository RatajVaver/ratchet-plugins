-- This is an example of RPR ability router, it will redirect all abilities listed in list.lua to specific hot-loaded files.

local ABILITIES = include("list.lua")

function getAbilityFile(id)
    return ABILITIES[id]
end

function getAbilityId(file)
    for k,v in pairs(ABILITIES)do
        if(v == file)then
            return k
        end
    end
end

function useAbility(player, abilityId, targets)
    local abilityFile = getAbilityFile(abilityId)
    if(abilityFile)then
        local path = string.format("Abilities/%s.lua", abilityFile)
        if(fileExists(path))then
            local ability = include(path)
            if(ability)then
                ability:Run(player, targets)
            else
                TotChat.NotifyLocal(player, string.format("Failed to load ability (%s)!", abilityFile))
            end
        else
            TotChat.NotifyLocal(player, string.format("File not found (%s)!", abilityFile))
        end
    end
end
on("RPR_useAbility", useAbility)