RegisterServerEvent('application:submit', function(appName, answers)
    local src = source
    local playerName = GetPlayerName(src)

    local data = Config.Applications[appName]
    if not data or not data.webhook then return end

    local embed = {
        {
            title = playerName .. " - " .. (data.label or appName),
            description = "",
            color = 65280
        }
    }

    for i, answer in ipairs(answers) do
        embed[1].description = embed[1].description .. string.format("**Q%d:** %s\n**A%d:** %s\n\n", i, data.questions[i], i, answer)
    end

    PerformHttpRequest(data.webhook, function() end, 'POST', json.encode({
        username = 'Application Bot',
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end)
