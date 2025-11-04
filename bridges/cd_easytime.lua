-- Bridge: cd_easytime (or similar "easytime" scripts)
-- Some versions emit a sync event or set GlobalState; if not, you can add a call to this tracker export from inside cd_easytime when weather changes:
-- exports['weather-tracker-webhook']:NotifyWeather(newWeather, {resource = 'cd_easytime'})

-- If your cd_easytime emits an event when weather changes, hook it below. Replace the event name with your version's event.
-- Examples to try/search in cd_easytime: 'cd_easytime:SyncWeather', 'cd_easytime:UpdateWeather', 'cd_easytime:OnWeatherChange'
RegisterNetEvent('cd_easytime:SyncWeather', function(data)
    print("Bridge recieved")
    local newWeather = data and (data.weather or data.Weather or data.type)
    TriggerServerEvent('weather-tracker:changed', newWeather)

end)
