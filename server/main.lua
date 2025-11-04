local json = json or require('json')

local lastWeather = nil
local lastSentAt = 0

-- Safe json encode
local function encode(data)
    local ok, res = pcall(function() return json.encode(data) end)
    if ok then return res else return "{}" end
end

local function tableMerge(a, b)
    local out = {}
    if a then for k,v in pairs(a) do out[k]=v end end
    if b then for k,v in pairs(b) do out[k]=v end end
    return out
end

local function sendDiscord(weather, meta)
    if WEBHOOK_URL == nil or WEBHOOK_URL == "" then
        print("^1[weather-tracker-webhook]^7 No WEBHOOK_URL set in config.lua; skipping webhook.")
        return
    end

    local now = os.time()
    if weather == lastWeather and (now - lastSentAt) < (DEBOUNCE_SECONDS or 5) then
        return
    end

    lastWeather = weather
    lastSentAt = now

    local srcRes = meta and (meta.resource or meta.source or meta.sourceResource) or "unknown"
    local extraFields = {}

    if meta and meta.fields and type(meta.fields) == "table" then
        for _, f in ipairs(meta.fields) do table.insert(extraFields, f) end
    end

    if EXTRA_FIELDS and type(EXTRA_FIELDS) == "table" then
        for _, f in ipairs(EXTRA_FIELDS) do table.insert(extraFields, f) end
    end

    local description = ("**Weather changed to:** `%s` **Source:** `%s`"):format(tostring(weather), tostring(srcRes))
    if meta and meta.description then
        description = description .. "\n" .. tostring(meta.description)
    end

    local embed = {
        title = SERVER_NAME .. " • Weather Update",
        description = description,
        color = 5793266, -- teal-ish
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        fields = extraFields
    }

    local payload = {
        username = WEBHOOK_USERNAME,
        avatar_url = WEBHOOK_AVATAR,
        embeds = { embed }
    }

    PerformHttpRequest(WEBHOOK_URL, function(err, text, headers) 
        if err ~= 204 and err ~= 200 then
            print(("^1[weather-tracker-webhook]^7 Webhook error code: %s; resp: %s"):format(err, tostring(text)))
        end
    end, "POST", encode(payload), { ["Content-Type"] = "application/json" })
end

-- Public API: export and event to notify the tracker of a weather change.
exports("NotifyWeather", function(weather, meta)
    sendDiscord(weather, meta)
end)

RegisterNetEvent("weather-tracker:changed", function(weather, meta)
    sendDiscord(weather, meta)
end)

-- Auto-detect via GlobalState or convar polling
CreateThread(function()
    local watchedKeys = GLOBALSTATE_KEYS or {}
    local lastValue = nil

    while true do
        if WATCH_GLOBALSTATE then
            local found = nil
            for _, key in ipairs(watchedKeys) do
                local v = GlobalState[key]
                if v ~= nil then
                    found = v
                    break
                end
            end
            if found ~= nil and found ~= lastValue then
                lastValue = found
                sendDiscord(found, {resource = "GlobalState"})
            end
        end

        -- fallback convar polling
        if FALLBACK_CONVAR_NAME and FALLBACK_CONVAR_NAME ~= "" then
            local cv = GetConvar(FALLBACK_CONVAR_NAME, "")
            if cv ~= "" and cv ~= lastValue then
                lastValue = cv
                sendDiscord(cv, {resource = "Convar:" .. FALLBACK_CONVAR_NAME})
            end
        end

        Wait(1500)
    end
end)

-- Helpful prints
AddEventHandler('onResourceStart', function(res)
    if res == GetCurrentResourceName() then
        print("^2[weather-tracker-webhook]^7 started. Configure WEBHOOK_URL in config.lua")
    end
end)
