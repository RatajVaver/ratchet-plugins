-- using this plugin you can create your own system similar to /bestiary in Knight's Sanity
-- you can create a gallery of monsters (place with puppets) where you can turn into any of them
-- interact button or command can then reset your sheet and appearance back to original

function onPuppetInteract(player, args)
    local puppetId = tonumber(args[1])
    local puppet = TotAdmin.GetPuppet(puppetId)
    if not puppet then
        printWarning("Puppet not found!")
        return
    end

    if(TotSudo.HasCharTag(player, "monster"))then
        player:Notify("Warning", "You are already using monster sheet! Reset first.", Color(255,150,20))
        return
    end

    emit("savesheet", player)

    TotSudo.AddCharTag(player, "monster")

    TotCustom.SetBody(player, TotCustom.GetBody(puppet))
    TotCustom.SetArmor(player, TotCustom.GetArmor(puppet))
    TotCustom.SetAccessories(player, TotCustom.GetAccessories(puppet))

    local sheet = puppet:GetSheet()
    if(sheet ~= "")then
        RPR.ImportSheet(player, sheet)
    end

    player:Notify( "Fist", ("Monster sheet applied (%s)!"):format( puppet:GetName() ), Color(255,80,80) )
end
on("mg_interact", onPuppetInteract)

function resetToOriginal(player)
    if(not TotSudo.HasCharTag(player, "monster"))then
        player:Notify("Warning", "You are not currently using monster sheet!", Color(255,150,20))
        return
    end

    emit("loadsheet", player)

    TotSudo.RemoveCharTag(player, "monster")
end
on("mg_reset", resetToOriginal)