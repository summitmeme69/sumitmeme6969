fx_version 'bodacious'
games { 'rdr3', 'gta5' }

server_export 'AddJob' 

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/cursor.png',
	'html/background.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js',
}

client_scripts {
	'config.lua',
    'client/cl_*.lua',
    "@srp-errorlog/client/cl_errorlog.lua"
}

server_scripts {
    'server/sv_*.lua'
}