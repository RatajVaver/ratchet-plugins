-- This is a base ability that all others may inherit from

local Ability = {}

Ability.Name = "N/A"

function Ability:Run(player, targets)
    TotChat.NotifyLocal(player, "This ability is not yet implemented in Ratchet!")
end

return Ability