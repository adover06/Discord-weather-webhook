-- =========================
-- weather-tracker-webhook
-- =========================
-- Configure your Discord webhook URL below.
-- Create one in your Discord server: Server Settings → Integrations → Webhooks.
WEBHOOK_URL = "https://discord.com/api/webhooks/1435190846256316466/7YJSXAMWDuTvx8q6Le37-Pk5tUtR5zQPhg8IG1WuRWeg9jnY8txIjt_LdtHhmPOC1-lE"

-- Optional: Server branding for the message
SERVER_NAME = "Los Angeles Roleplay"
WEBHOOK_USERNAME = "Weather Watcher"
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

-- Allow sending the test payload via an in-game/server command.
-- If ENABLE_TEST_COMMAND = true, a command named TEST_COMMAND_NAME will be registered.
-- If TEST_COMMAND_RESTRICT_TO is non-empty, only players whose identifiers match one of the strings
-- in the list will be allowed to use the command (use full identifiers like "steam:..." or "license:...").
ENABLE_TEST_COMMAND = true
TEST_COMMAND_NAME = "sendWebhookTest"
TEST_COMMAND_RESTRICT_TO = {
     -- e.g. "steam:110000112345678", "license:abcd1234..."
}
