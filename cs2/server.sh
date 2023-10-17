#!/bin/bash

./cs2 -dedicated +map "${CS2_MAP}" +game_alias competitive +game_alias competitive +sv_password "${CS2_JOIN_PASSWORD}" +rcon_password "${CS2_RCON_PASSWORD}" +hostname "${CS2_HOSTNAME}" +sv_lan 0
