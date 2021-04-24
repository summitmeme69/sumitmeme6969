fx_version 'bodacious'
games { 'rdr3', 'gta5' }

author 'whiteknight'
description ''
version '1.0.0'

client_script{
	'client.lua',
	'gui.lua',
	"@srp-errorlog/client/cl_errorlog.lua"
}

server_script 'server.lua'
