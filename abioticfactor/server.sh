#!/bin/bash

xvfb-run wine AbioticFactorServer-Win64-Shipping.exe -log -newconsole -useperfthreads -NoAsyncLoadingThread -MaxServerPlayers=6 -PORT=$GAMEPORT -QUERYPORT=$QUERYPORT -tcp -ServerPassword=$SERVERPASSWORD -SteamServerName="$SERVERNAME" -WorldSaveName="Cascade"
