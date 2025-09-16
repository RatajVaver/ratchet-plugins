-- These events are custom defined and can be called from other plugins, mods, Tot scripts or even website requests

function generalEvent(args)
    print("General event triggered with args:")
    for _,v in ipairs(args)do
        print("- " .. v)
    end
end
on("customEvent1", generalEvent)

function playerEvent(player, args)
    print("Player event triggered with args:")
    for _,v in ipairs(args)do
        print("- " .. v)
    end

    TotChat.Notify(player, "I know what you did.")
end
on("customEvent2", playerEvent)

function targetsEvent(player, targets, args)
    print("Targets event triggered with args:")
    for _,v in ipairs(args)do
        print("- " .. v)
    end

    for _,v in ipairs(targets)do
        TotChat.Notify(player, "I know what you did.")
    end
end
on("customEvent3", targetsEvent)

-- Scheduled event by schedule.json

function scheduledEvent()
    print("Well, well, well.")
end
on("scheduled_event", scheduledEvent)

-- Admin Tool interaction

function zoneEnter(player, tool, arg)
    player:Notify("Footprints", "You have entered a zone!", Color(66, 245, 200))
end
on("zone_enter", zoneEnter)

function zoneExit(player, tool, arg)
    player:Notify("Footprints", "You have left a zone!", Color(66, 245, 200))
end
on("zone_exit", zoneExit)

function generalInteraction(player, tool, arg)
    if(getType(tool) == "TotPuppet")then
        player:Notify("Student", "You're interacting with: " .. tool:GetName(), Color(164, 227, 98))
    else
        player:Notify("Student", "You're interacting with: " .. tool:GetActorName(), Color(164, 227, 98))
    end
end
on("interact", generalInteraction)