-- Area of Effects spell using Knight's Sanity

local function processAoE(player, abilityFile, data)
    local path = string.format("%s.lua", abilityFile)
    if(fileExists(path))then
        local ability = include(path)
        if(ability)then
            ability:AoE(player, data)
        else
            TotChat.NotifyLocal(player, string.format("Failed to load ability (%s)!", abilityFile))
        end
    else
        TotChat.NotifyLocal(player, string.format("File not found (%s)!", abilityFile))
    end
end

local function pointAoE(player, point, command)
    local abilityFile = TotSudo.GetCharString(player, "spell")
    if(command ~= "" or abilityFile == "")then
        return
    end

    TotSudo.RemoveCharString(player, "spell")
    processAoE(player, abilityFile, { point = point })
end
on("KS_selectedPoint", pointAoE)