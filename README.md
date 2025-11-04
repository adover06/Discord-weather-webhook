# weather-tracker-webhook

Tracks server weather changes and sends them to a Discord webhook.
Works out-of-the-box by watching common `GlobalState` keys used by popular weather scripts.
Includes optional bridges for `qb-weathersync` and `cd_easytime`, and a simple API to notify manually.

---

## Installation

1. Drop the `weather-tracker-webhook` folder into your server's `resources` directory.
2. Open `config.lua` and set `WEBHOOK_URL` to your Discord webhook.
3. In your `server.cfg`, add:
   ```cfg
   ensure weather-tracker-webhook
   ```
4. (Optional) If your weather script does **not** set a `GlobalState` key or a convar:
   - Enable the bridge you use by uncommenting the file in `fxmanifest.lua`, **or**
   - Add a line where you change the weather:
     ```lua
     exports['weather-tracker-webhook']:NotifyWeather(newWeather, {resource = 'your-weather-script'})
     ```

### Supported Detection Methods

- **GlobalState** (auto): If your weather system writes one of these keys, it is detected automatically:
  - `weather`, `Weather`, `currentWeather`, `syncWeather`
- **Convar fallback**: If your script stores the current weather in a convar (e.g., `sets weather EXTRASUNNY`), set `FALLBACK_CONVAR_NAME` in `config.lua`.
- **Bridges** (optional):
  - `bridges/qb_weathersync.lua`
  - `bridges/cd_easytime.lua`
- **Direct export**:
  ```lua
  exports['weather-tracker-webhook']:NotifyWeather(newWeather, {resource = 'my-weather'})
  -- or
  TriggerEvent('weather-tracker:changed', newWeather, {resource = 'my-weather'})
  ```

## Webhook Format

Sends a single embed like:

- Title: `<SERVER_NAME> • Weather Update`
- Description: 
  - **Weather changed to:** `RAIN`
  - **Source:** `qb-weathersync` (or GlobalState / Convar / manual)
- Timestamp: UTC
- Extra fields: any provided via `meta.fields` or `EXTRA_FIELDS`

## Spam Protection

Identical weather values within `DEBOUNCE_SECONDS` (default 5s) are ignored.

## Troubleshooting

- **No messages in Discord**: Make sure `WEBHOOK_URL` is set and the resource is `ensure`d after your framework and weather script.
- **Using cd_easytime/easytime**: If no GlobalState key is present, enable the bridge or add the single export call where weather changes.
- **Multiple messages per change**: Increase `DEBOUNCE_SECONDS` in `config.lua`.

---

Made for Chelsey Reyes project users. Enjoy!
