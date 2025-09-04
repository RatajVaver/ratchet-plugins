local Ability = {}

Ability.Shape = 1 -- sphere
Ability.Reach = 15
Ability.Radius = 2
Ability.Color = Color(120, 40, 0)

function Ability:Run(player, targets)
    local abilityPath = getFilePath():removeSuffix(".lua")
    TotSudo.SetCharString(player, "spell", abilityPath)
    KS.SelectPoint(player, self.Shape, self.Reach, self.Radius, 0, "", self.Color, "")
    TotChat.SendLocal(player, "/rr")
end

function Ability:AoE(player, data)
    TotChat.SendLocal(player, player:GetName() .. " casts FIREBALL!", 20)
    local targets = KS.ProcessAoE(player, data.point, self.Shape, self.Radius, 0, true, false, self.Color)
    for _,target in ipairs(targets)do
        local damageDice = "8d6"
        local dexSave = RPR.Roll(target, "Dexterity Saving Throw")
        if(dexSave >= 14)then
            TotChat.SendLocal(target, target:GetName() .. " manages to avoid the worst and takes only half damage.", 20)
            damageDice = "4d6"
        else
            TotChat.SendLocal(target, target:GetName() .. " fails to avoid the blast and takes full damage.", 20)
        end

        local damageTaken = Dice.Roll(damageDice)
        RPR.ModifyStat(target, "Hit Points", -damageTaken)

        local currentHp, maxHp = RPR.GetStat(player, "Hit Points")
        local messageFormat = "%s has lost %d HP for a total of %d/%d"
        TotChat.SendLocal(target, messageFormat:format(target:GetName(), damageTaken, currentHp, maxHp), 20)
    end
end

return Ability