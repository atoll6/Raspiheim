#!/bin/bash
export PATH=/usr/local/bin/:$PATH
cp /etc/resolv.conf /
sed -i s/"nameserver ".*/"nameserver 1.1.1.1"/g /resolv.conf
cp /resolv.conf /etc/resolv.conf

# Upgrade Valheim to latest Version
if [ ! -f /valheim/start_server.sh ] || [ $UPDATE = enabled ] || [ $UPDATE = 1 ]; then
cd /steamcmd
echo "Updating the server..."
export LD_LIBRARY_PATH="/steamcmd/linux32:$LD_LIBRARY_PATH" && \
box64 ./linux32/steamcmd +login anonymous +quit >/dev/null;
export LD_LIBRARY_PATH="/steamcmd/linux32:$LD_LIBRARY_PATH" && \
box64 ./linux32/steamcmd +login anonymous +quit >/dev/null;
export LD_LIBRARY_PATH="/steamcmd/linux32:$LD_LIBRARY_PATH" && \
box64 ./linux32/steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /valheim +login anonymous +app_update 896660 validate +quit;
fi;

# Manage Persistency
cp -f /scripts/start_server.sh.tpl	/valheim/start_server.sh

cd /valheim

# Start Server
chmod +x ./start_server.sh
export LOG_FILE="/data/logs/valheim-$(date '+%d.%m.%y - %H:%M:%S').log"
touch $LOG_FILE
echo "$LOG_FILE" > /data/logs/log-link.txt
./start_server.sh 2>/dev/null | tee -a "$LOG_FILE"
sleep 600
