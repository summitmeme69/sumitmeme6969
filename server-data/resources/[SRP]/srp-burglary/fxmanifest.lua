fx_version 'adamant'
games { 'gta5' }

this_is_a_map 'yes'

client_script 'client.lua'
server_script 'server.lua'
client_script 'safeCracking.lua'
client_script "@srp-errorlog/client/cl_errorlog.lua"

data_file 'DLC_ITYP_REQUEST' 'stream/v_int_shop.ytyp'

files {
 'stream/v_int_shop.ytyp'
}
