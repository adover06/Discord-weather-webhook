fx_version 'cerulean'
game 'gta5'

name 'weather-tracker-webhook'
author 'ChatGPT'
version '1.0.0'
description 'Tracks weather changes and posts them to a Discord webhook. Includes optional bridges for popular weather scripts.'

server_scripts {
    'config.lua',
    'server/main.lua',
    --'bridges/cd_easytime.lua'
    -- Optional bridges (enable the one you use by removing the leading -- below)
    -- 'bridges/qb_weathersync.lua',

}
