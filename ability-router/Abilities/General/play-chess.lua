local Ability = {}

function Ability:Run(player, targets)
    emit("chess_play", player, targets[1])
end

return Ability