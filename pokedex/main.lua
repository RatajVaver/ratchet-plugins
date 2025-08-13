-- this plugin showcases the ability to communicate with web API and Tot scripts

function searchForPokemon(player, args)
    local name = string.lower(table.concat(args, "-"))

    TotChat.Notify(player, "Searching..")

    Web.Get("https://pokeapi.co/api/v2/pokemon/" .. name, function(success, status, body)
        if success then
            local data = JSON.parse(body)
            if(data and data.name)then
                local name = data.name:gsub("^%l", string.upper)
                local image = data.sprites.other["official-artwork"]["front_default"]
                TotAdmin.RunScript({ "pokedex", "response", player.ID, name, image })
                return
            end
        end

        TotChat.Notify(player, "Not found!")
    end)
end
on("pokemon_search", searchForPokemon)