#!/bin/bash

replace_config() {
  sed -i "s/${1}=.*/${1}=${2}/g"  KFGame/Config/LinuxServer-KFGame.ini
}

replace_config AdminPassword "${KF2_ADMINPASSWORD}"
replace_config GamePassword "${KF2_SERVERPASSWORD}"
replace_config ServerName "${KF2_SERVERNAME}"
replace_config GameDifficulty "${KF2_DIFFICULTY}"
replace_config MaxPlayers "${KF2_MAXPLAYERS}"

./Binaries/Win64/KFGameSteamServer.bin.x86_64 "${KF2_MAP}"
