resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {
    'client/dist/index.html',
    'client/dist/js/app.js',
    'client/dist/css/app.css',
}

client_script "@srp-infinity/client/cl_lib.lua"
server_script "@srp-infinity/server/sv_lib.lua"

client_scripts {
    'client/*.lua',
    'config.lua',
}

server_script {
    'server/*.lua',
}

ui_page 'client/dist/index.html'