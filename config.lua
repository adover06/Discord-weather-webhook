-- =========================
-- weather-tracker-webhook
-- =========================
-- Configure your Discord webhook URL below.
-- Create one in your Discord server: Server Settings → Integrations → Webhooks.
WEBHOOK_URL = "https://discord.com/api/webhooks/1435190846256316466/7YJSXAMWDuTvx8q6Le37-Pk5tUtR5zQPhg8IG1WuRWeg9jnY8txIjt_LdtHhmPOC1-lE"

-- Optional: Server branding for the message
SERVER_NAME = "Weather Tracker"
WEBHOOK_USERNAME = "Weather Bot"
WEBHOOK_AVATAR = "" -- leave blank to use the webhook's default avatar

-- Debounce identical messages (in seconds). Prevents spam if a script spams the same weather repeatedly.
DEBOUNCE_SECONDS = 5

-- Watch common GlobalState keys used by popular weather scripts. If your weather system sets any of these,
-- the tracker will automatically pick them up without any bridge.
WATCH_GLOBALSTATE = true
GLOBALSTATE_KEYS = {
    "weather",          -- QBCore / custom scripts commonly use this
    "Weather",          -- capitalization variants
    "currentWeather",   -- other scripts
    "syncWeather",      -- generic
}

FALLBACK_CONVAR_NAME = "weather"

-- Advanced: Extra metadata to always include in webhook embeds.
EXTRA_FIELDS = {
    -- Example: {name = "Region", value = "Los Santos", inline = true},
}
