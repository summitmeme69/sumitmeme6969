fx_version 'adamant'
games { 'gta5' }

client_script 'client/main.lua'
client_script "@srp-errorlog/client/cl_errorlog.lua"
server_script 'server/main.lua'
client_script "@srp-infinity/client/cl_lib.lua"
server_script "@srp-infinity/server/sv_lib.lua"

ui_page('client/html/index.html')

files {
    'client/html/index.html',
    'client/html/sounds/*.ogg',
}
