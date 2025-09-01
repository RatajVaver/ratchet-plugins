-- this plugin uses Knight's Sanity day/night cycle to run code at every midnight
-- once per X days a fullmoon event is activated

local DAYS_PER_FULL_MOON = 5
local EVENT_LENGTH_HOURS = 3

function atMidnight()
    TotChat.Broadcast("It's midnight!")

    local daysSinceLastFullMoon = TotSudo.GetGlobFloat("fullMoon") + 1
    if daysSinceLastFullMoon >= DAYS_PER_FULL_MOON then
        startFullMoon()
        daysSinceLastFullMoon = 0
    end

    TotSudo.SetGlobFloat("fullMoon", daysSinceLastFullMoon)
end
on("KS_midnight", atMidnight)

function startFullMoon()
    TotChat.Alert("And it's also full moon! AWO0OO0ooOoo~!")
    TotAdmin.RunScript({ "fullmoon", "start" })
    setTimer(endFullMoon, EVENT_LENGTH_HOURS*60*60*1000, 1)
end

function endFullMoon()
    TotChat.Alert("Full moon is over!")
    TotAdmin.RunScript({ "fullmoon", "end" })
end