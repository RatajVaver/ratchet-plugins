local Ability = {}

Ability.Name = "Inspect"

function Ability:Run(player, targets)
    local target = targets[1]
    if not target then return end

    local targetName = target:GetName()
    local description = "You inspect <span style=\"bold\">" .. targetName .. "</>. They wear the following equipment:"
    local sheet = RPR.GetSheet(target)
    for _,v in ipairs(sheet.runes)do
        description = description .. "\n- <itemid=" .. v .. ">"
    end

    TotChat.NotifyLocal(player, description)
end

return Ability