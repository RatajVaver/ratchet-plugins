-- Discord webhooks
-- the variable DISCORD_WEBHOOK_URL in this example is defined in global.lua placed in the root plugins directory
-- this way you can hide secrets from the plugin code itself
-- exports.discord.send("Hello") can be used to call this webhook from any other plugin
-- discord_webhook general event can be called from any Tot script to trigger this webhook as well

function sendWebhookMessage(message)
    Web.Post(DISCORD_WEBHOOK_URL, { content = message }, function(success, status, body)
        if(not success)then
            print("Failed to send the webhook!", status, body)
        elseif(status ~= 200 and status ~= 204)then
            local error = "N/A"
            local response = JSON.parse(body)
            if(response and response.message)then
                error = response.message
            end
            print("Error " .. status .. ": " .. error)
        end
    end)
end
export("send", sendWebhookMessage)
on("discord_webhook", sendWebhookMessage)

function onLoad()
    local now = os.time()
    sendWebhookMessage("Server is fully loaded and you can connect!\nIt took the server hamster " .. (now - START_TIME) .. " seconds to boot it up.")
end
once("server_start", onLoad) -- send this only once when the server loads, not every time plugin is reloaded