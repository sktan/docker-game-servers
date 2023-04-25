#!/bin/bash

replace_config() {
  if grep -q "${1}" "$SERVER/csgo/cfg/server.cfg"; then
    sed -i "s/${1} .*/${1} \"${2}\"/g" "$SERVER/csgo/cfg/server.cfg"
  else
    echo "${1} ${2}" >> "$SERVER/csgo/cfg/server.cfg"
  fi
}

replace_config "hostname" "${CSGO_HOSTNAME}"
replace_config "rcon_password" "${CSGO_RCON_PASSWORD}"
replace_config "sv_password" "${CSGO_JOIN_PASSWORD}"
replace_config "sv_setsteamaccount" "${CSGO_STEAM_ACCOUNT}"

# Loop through CSGO_SERVER_ADMINS variable delimited by commas and echo each variable to admins_simple.ini file
if [ "${CSGO_SERVER_ADMINS}" != "" ]; then
  for i in $(echo "${CSGO_SERVER_ADMINS}" | tr "," "\n"); do
    echo "\"${i}\" \"99:z\"" >> "$SERVER/csgo/addons/sourcemod/configs/admins_simple.ini"
  done
fi

./srcds_run -console -port ${CSGO_PORT} -usercon -tickrate 128 +game_type 0 +game_mode 1 +mapgroup mg_active +map "${CSGO_MAP}"
