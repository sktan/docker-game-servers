#!/bin/bash

if [[ ! -e world.cfg ]]; then
cat >world.cfg <<EOF
world=/home/terraria/world/newterra.wld
worldpath=/home/terraria/world/
autocreate=3
worldname=newterra
difficulty=1
maxplayers=10
password=${TERRARIA_PASSWORD}
port=7777
priority=1
EOF
fi

./TerrariaServer -config world.cfg