-- this example showcases the ability to permanently store files
-- data can be tied to a player and their character and persist even through wipes
-- we also use export function to be able to use this plugin as a module that other plugins can communicate with
-- in other plugins we can use: exports.storage.get(player) and exports.storage.set(player, data)
-- make sure that you use correct plugin name (path) as a key of the exports array
-- also make sure that the path "data/characters" relative to your working directory exists

function getCharData(player)
    if(player)then
        local name = player:GetRealName()
        local steamId = player:GetSteamID()
        if(name and steamId ~= "0")then
            local path = ("data/characters/%s_%s.json"):format(steamId, name)
            return JSON.load("data/characters/" .. name .. ".json") or {}
        end
    end
    return {}
end
export("get", getCharData)

function setCharData(player, data)
    if(player)then
        local name = player:GetRealName()
        local steamId = player:GetSteamID()
        if(name and steamId ~= "0")then
            local path = ("data/characters/%s_%s.json"):format(steamId, name)
            if(JSON.save(path, data))then
                return true
            end
        end
    end
    return false
end
export("set", setCharData)