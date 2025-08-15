-- this example works with the storage plugin to save RPR character sheet data
-- it also showcases the use of exports

function saveSheet(player)
    local data = {
        sheet = RPR.ExportSheet(player)
    }

    -- change this to the actual path to your storage plugin relative to plugins folder
    if(exports["community/storage"].set(player, data))then
        TotChat.Notify(player, "Character sheet saved!")
    else
        TotChat.Warn(player, "Failed to save character sheet!")
    end
end
on("savesheet", saveSheet)