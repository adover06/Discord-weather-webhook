-- Server: receive forwarded weather updates from clients and trigger the webhook resource once (deduped)

local lastWeather = nil
local lastSentAt = 0
local DEBOUNCE_SECONDS = 5 -- local debounce to avoid many clients forwarding at once

RegisterNetEvent('cd_easytime_webhook_bridge:forwardWeather', function(payload)
    local src = source
    if not payload or not payload.weather then return end
    local weather = tostring(payload.weather)
    local now = os.time()
    if weather == lastWeather and (now - lastSentAt) < DEBOUNCE_SECONDS then
        return
    end
    lastWeather = weather
    lastSentAt = now

    local meta = { resource = 'cd_easytime', forwardedBy = src, info = payload.info }

    -- Trigger the existing webhook handler in your weather-tracker-webhook resource
    -- This assumes that resource registers a server event 'weather-tracker:changed'
    TriggerEvent('weather-tracker:changed', weather, meta)

    print(('^2[cd_easytime-webhook-bridge]^7 Forwarded weather "%s" to webhook (from source %s)'):format(weather, tostring(src)))
end)

-- Optional: server console command to force-send a weather message
RegisterCommand('forwardWeatherTest', function(source, args, raw)
    if source ~= 0 then
        print('This command must be run from the server console.')
        return
    end
    local weather = args[1] or 'CLEAR'
    TriggerEvent('weather-tracker:changed', weather, { resource = 'cd_easytime', forwardedBy = 'console' })
    print(('Forwarded test weather "%s" to webhook'):format(weather))
end, false)
