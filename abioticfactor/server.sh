#!/bin/bash

# Args can be found here: https://github.com/DFJacob/AbioticFactorDedicatedServer/wiki/Technical-%E2%80%90-Launch-Parameters
xvfb-run wine AbioticFactorServer-Win64-Shipping.exe -log -newconsole -useperfthreads -MaxServerPlayers=6 -PORT=$GAMEPORT -QUERYPORT=$QUERYPORT -ServerPassword="$SERVERPASSWORD" -SteamServerName="$SERVERNAME" -AdminPassword="$ADMINPASSWORD" -WorldSaveName="Cascade"
