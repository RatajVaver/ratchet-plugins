local Ability = include("ability.lua")

Ability.SaveType = "AC"
Ability.UseMessage = "%s used %s on %s."
Ability.RollMessage = "%s rolls %s vs %d (%s) = %s"

function Ability:AttackFormula(caster, target)
    return 0
end

function Ability:SaveFormula(caster, target)
    local AC = RPR.GetStat(target, "Armor Class")
    return AC
end

function Ability:DamageRoll(caster, target)
    return 0
end

function Ability:DamageFormula(caster, target)
    return 0
end

function Ability:AfterHit(caster, target)
    -- you can fill this in inheriting abilities
end

function Ability:Run(caster, targets)
    local targetNames = {}
    for _, target in ipairs(targets) do
        table.insert(targetNames, target:GetName())
    end

    local chatMessage = self.UseMessage:format(caster:GetName(), self.Name, table.concat(targetNames, ", "))
    TotChat.SendLocal(caster, chatMessage, 20)

    for _, target in ipairs(targets) do
        local attackRoll = Dice.D20()
        local attackBonus = self:AttackFormula(caster, target)
        local casterRoll = attackRoll + attackBonus
        local targetRoll = self:SaveFormula(caster, target)
        local success = casterRoll >= targetRoll
        local critical = false

        if(attackRoll == 20)then
            critical = true
            success = true
        end

        local successText = "Miss"
        if(critical)then
            successText = "Critical Hit!"
        elseif (success) then
            successText = "Hit"
        end

        local casterRollText = attackRoll
        if(attackBonus > 0)then
            casterRollText = casterRollText .. "+" .. attackBonus .. "=" .. casterRoll
        elseif(attackBonus < 0)then
            casterRollText = casterRollText .. attackBonus .. "=" .. casterRoll
        end

        local attackRollMessage = self.RollMessage:format(caster:GetName(), casterRollText, targetRoll, self.SaveType, successText)
        TotChat.SendLocal(target, attackRollMessage, 20)

        if (success) then
            local damageRoll = self:DamageRoll(caster, target)
            if(critical)then
                damageRoll = damageRoll * 2
            end

            local currentHp, maxHp = RPR.GetStat(target, "Hit Points")

            local totalDamage = damageRoll + self:DamageFormula(caster, target)
            RPR.ModifyStat(target, "Hit Points", -totalDamage)

            local newHp = math.max(0, currentHp - totalDamage)
            local healthChangeText = target:GetName() .. " has lost " .. totalDamage .. " HP for a total of " .. newHp .. "/" .. maxHp .. "."
            TotChat.SendLocal(target, healthChangeText, 20)

            self:AfterHit(caster, target)
        end
    end

    return true
end

return Ability