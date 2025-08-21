-- this example works with the storage plugin (using exports) to save RPR sheet data and TotCustom preset

function saveSheet(player)
    local data = {
        sheet = RPR.ExportSheet(player),
        body = TotCustom.GetBody(player),
        armor = TotCustom.GetArmor(player),
        accessories = TotCustom.GetAccessories(player)
    }

    if(exports.storage.set(player, data))then
        TotChat.Notify(player, "Character sheet saved!")
    else
        TotChat.Warn(player, "Failed to save character sheet!")
    end
end
on("savesheet", saveSheet)

function loadSheet(player)
    local data = exports.storage.get(player)
    if(data and data.sheet)then
        RPR.ImportSheet(player, data.sheet)

        if(data.body)then
            TotCustom.SetBody(player, data.body)
        end

        if(data.armor)then
            TotCustom.SetArmor(player, data.armor)
        end

        if(data.accessories)then
            TotCustom.SetAccessories(player, data.accessories)
        end

        TotChat.Notify(player, "Character sheet loaded!")
    else
        TotChat.Warn(player, "You don't have saved character sheet!")
    end
end
on("loadsheet", loadSheet)