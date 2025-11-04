-- Bridge: qb-weathersync
-- Enable this file in fxmanifest once you confirm the event names match your qb-weathersync version.
-- Many versions set GlobalState.weather already, which the tracker auto-detects.
-- If yours does not, hook the server-side setter event below.

-- Example events (may vary between forks):
-- AddEventHandler('qb-weathersync:server:setWeather', function(newWeather) ... end)
-- AddEventHandler('qb-weathersync:server:toggleDynamicWeather', function(state) ... end)

-- Replace 'qb-weathersync:server:setWeather' with the actual event in your script (check its server/*.lua).
RegisterNetEvent('qb-weathersync:server:setWeather', function(newWeather)
    print(("^6[weather-tracker-webhook][bridge:qb-weathersync]^7 setWeather event newWeather='%s'")
        :format(tostring(newWeather)))
    -- Forward to tracker
    TriggerEvent('weather-tracker:changed', newWeather, {
        resource = 'qb-weathersync',
        fields = {
            { name = "Source Script", value = "qb-weathersync", inline = true }
        }
    })
end)
