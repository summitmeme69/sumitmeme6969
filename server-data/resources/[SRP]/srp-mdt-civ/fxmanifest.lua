fx_version 'adamant'
games { 'gta5' }

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/vue.min.js",
    "ui/script.js",
    "ui/badge.png",
	"ui/footer.png",
	"ui/mugshot.png"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"sv_mdt.lua",
	"sv_vehcolors.lua"
}

client_script "cl_mdt.lua"
client_script "@srp-errorlog/client/cl_errorlog.lua"