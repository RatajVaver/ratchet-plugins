-- Custom User Interface (cui.ratajmods.net)

function openCUI(player)
    KS.CreateCUI(player, [[Title|Control Panel
MinSize|250x
MaxSize|300x900
CTxt|Hello world and Lorem ipsum dolor sit amet.
BtnRow|2
Btn|Cmd|rcui|Refresh CMD|
Btn|RCT|cui|Refresh RCT|#574e0e
Btn|RCT|soup|Soup|#0e5557
Btn|RCT|cui-redlight REDLIGHT!|Redlight|#570e0e]])
end
on("cui", openCUI)

local redlight = false
function toggleRedlight(player, args)
    redlight = not redlight
    KS.Redlight(redlight, false)

    local notice = table.concat(args, " ")
    if (notice:len() > 0) then
        TotChat.Alert(notice)
    end
end
on("cui-redlight", toggleRedlight)
