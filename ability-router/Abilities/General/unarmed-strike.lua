local Ability = hotLoad("../Base/attack.lua")

Ability.Name = "Unarmed Strike"
Ability.DamageType = "Bludgeoning"

function Ability:AttackFormula(caster, target)
    local _, STR = RPR.GetSkill(caster, "Strength")
    local _, DEX = RPR.GetSkill(caster, "Dexterity")

    if(RPR.HasPerk(caster, "Class: Monk"))then
        return math.max(STR, DEX)
    end

    return STR
end

function Ability:DamageRoll(caster, target)
    if(RPR.HasPerk(caster, "Class: Monk"))then
        return Dice.D4()
    end

    return 0
end

function Ability:DamageFormula(caster, target)
    local _, STR = RPR.GetSkill(caster, "Strength")
    local _, DEX = RPR.GetSkill(caster, "Dexterity")

    if(RPR.HasPerk(caster, "Class: Monk"))then
        return math.max(STR, DEX)
    end

    return 1 + STR
end

return Ability