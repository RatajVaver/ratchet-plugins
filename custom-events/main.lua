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