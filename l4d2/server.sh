#!/bin/bash

replace_config() {
  if grep -q "${1}" "$SERVER/left4dead2/cfg/server.cfg"; then
    sed -i "s/${1} .*/${1} \"${2}\"/g" "$SERVER/left4dead2/cfg/server.cfg"
  else
    echo "${1} ${2}" >> "$SERVER/left4dead2/cfg/server.cfg"
  fi
}

if [ "${L4D2_GAMEMODE}" == "versus" ]; then
  cp -rf $HOME/mods/zonemod/* $SERVER/left4dead2/
else
  cp -rf $HOME/mods/sourcemod_base/* $SERVER/left4dead2/
fi

replace_config "sm_cvar survivor_friendly_fire_factor_easy" "${L4D2_FRIENDLYFIRE}"
replace_config "sm_cvar survivor_friendly_fire_factor_normal" "${L4D2_FRIENDLYFIRE}"
replace_config "sm_cvar survivor_friendly_fire_factor_hard" "${L4D2_FRIENDLYFIRE}"
replace_config "sm_cvar survivor_friendly_fire_factor_expert" "${L4D2_FRIENDLYFIRE}"

replace_config "hostname" "${L4D2_HOSTNAME}"
replace_config "rcon_password" "${L4D2_RCON}"

replace_config "sm_cvar mp_gamemode" "${L4D2_GAMEMODE}"

replace_config "z_difficulty" "${L4D2_DIFFICULTY}"
[ "$L4D2_SERVER_PASSWORD" != "nopasswd" ] && replace_config "sv_password" "${L4D2_SERVER_PASSWORD}"

# Install workshop collections
[ "$L4D2_WORKSHOP_IDS" != "empty" ] && python3 $HOME/workshop.py -o "$SERVER/left4dead2/addons/workshop" $L4D2_WORKSHOP_IDS

./srcds_run -console -game left4dead2 -insecure +maxplayers "${L4D2_PLAYERS}" +map "${L4D2_MAP}"
