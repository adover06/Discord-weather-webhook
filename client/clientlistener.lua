
RegisterNetEvent('cd_easytime:SyncWeather', function(data)
    if not data then return end
    local weather = data.weather or data
    TriggerServerEvent('cd_easytime_webhook_bridge:forwardWeather', { weather = weather, info = data.info })
end)

-- Also listen to ForceUpdate which may include weather in the payload
RegisterNetEvent('cd_easytime:ForceUpdate', function(data)
    if not data then return end
    local weather = data.weather or (data and data.weather)
    if weather then
        TriggerServerEvent('cd_easytime_webhook_bridge:forwardWeather', { weather = weather, info = data.info })
    end
end)