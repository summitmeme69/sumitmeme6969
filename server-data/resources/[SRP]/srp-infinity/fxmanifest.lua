fx_version "adamant"
games {"gta5"}
version "69"

client_scripts {
    "client/cl_*.lua"
}

server_scripts {
    "server/sv_*.lua"
}

server_script "tests/sv_*.lua"
client_script "tests/cl_*.lua"
