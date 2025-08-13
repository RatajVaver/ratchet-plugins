local URL = "https://lichess.org/api/challenge/open"
local postData = "name=Conan Exiles Chess Match"

function createChallenge(player, target)
    Web.Post(URL, postData, function(success, status, body)
        if(success)then
            local data = JSON.parse(body)
            if(data and data.url)then
                TotAdmin.RunScript({ "chess", player.ID, data.url })
                TotAdmin.RunScript({ "chess", target.ID, data.url })
                return
            end
        end

        TotChat.Notify(player, "Failed to create chess challenge!")
    end)
end
on("chess_play", createChallenge)