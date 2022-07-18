fx_version 'adamant'

game 'gta5'

name ''
description ''

ui_page('client/html/UI.html')

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'config.lua'
}

files {
	'client/html/UI.html',
	'client/html/script.js',
    'client/html/style.css',
	'client/html/imgs/Logo.png'
}
