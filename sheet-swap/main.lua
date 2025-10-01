-- this is a working example of easy RPR sheet swap, and it saves everything, including buffs and cooldowns

function saveSheet(player, args)
    -- unescaped string in path like this would generally be very unsafe!
    -- but we'll keep it simple for this example
    local fileName = "ratchet/data/sheet_" .. args[1] .. ".json"
    local data = {
        creator = player:GetName(),
        sheet = RPR.ExportSheet(player)
    }

    if(JSON.save(fileName, data))then
        TotChat.Notify(player, "Sheet saved!")
    else
        TotChat.Notify(player, "Failed to save sheet!")
    end
end
on("swap_save", saveSheet)

function loadSheet(player, args)
    local fileName = "ratchet/data/sheet_" .. args[1] .. ".json"
    local data = JSON.load(fileName)
    if(not data)then
        TotChat.Notify(player, "Sheet not found!")
        return
    end

    if(RPR.ImportSheet(player, data.sheet))then
        TotChat.Notify(player, "Sheet loaded!")
    else
        TotChat.Notify(player, "Failed to import sheet!")
    end
end
on("swap_load", loadSheet)