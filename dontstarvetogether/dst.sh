#!/bin/bash

DIR_MODS_SYS="/home/steam/dontstarvetogether/mods"
DIR_MODS_USR="/home/steam/.klei/DoNotStarveTogether/MyDediServer/mods"

if [[ -L "${DIR_MODS_SYS}" ]]; then
  rm -rf "${DIR_MODS_SYS}"
  cp -r "${DIR_MODS_USR}" "${DIR_MODS_SYS}"
fi

if [ ! -d "${DIR_MODS_USR}" ]; then
  mkdir -p "${DIR_MODS_USR}"
  cp -r "${DIR_MODS_SYS}" "${DIR_MODS_USR}"
fi

rm -rf "${DIR_MODS_SYS}"
ln -s "${DIR_MODS_USR}" "${DIR_MODS_SYS}"

run_shared=(./dontstarve_dedicated_server_nullrenderer_x64)
run_shared+=(-console)
run_shared+=(-cluster "MyDediServer")
run_shared+=(-monitor_parent_process $$)

"${run_shared[@]}" -shard Caves  | sed 's/^/Caves:  /' &
"${run_shared[@]}" -shard Master | sed 's/^/Master: /'