#!/bin/bash
if [ ! -f ${STEAMCMD_DIR}/steamcmd.sh ]; then
    echo "SteamCMD not found!"
    wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
    tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz
    rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz
fi

echo "---Update SteamCMD---"
if [ "${USERNAME}" == "" ]; then
    ${STEAMCMD_DIR}/steamcmd.sh \
    +login anonymous \
    +quit
else
    ${STEAMCMD_DIR}/steamcmd.sh \
    +login ${USERNAME} ${PASSWRD} \
    +quit
fi

echo "---Update Server---"
if [ "${USERNAME}" == "" ]; then
    if [ "${VALIDATE}" == "true" ]; then
        ${STEAMCMD_DIR}/steamcmd.sh \
        +login anonymous \
        +force_install_dir ${SERVER_DIR} \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +login anonymous \
        +force_install_dir ${SERVER_DIR} \
        +app_update ${GAME_ID} \
        +quit
    fi
else
    if [ "${VALIDATE}" == "true" ]; then
        ${STEAMCMD_DIR}/steamcmd.sh \
        +login ${USERNAME} ${PASSWRD} \
        +force_install_dir ${SERVER_DIR} \
        +app_update ${GAME_ID} validate \
        +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh \
        +login ${USERNAME} ${PASSWRD} \
        +force_install_dir ${SERVER_DIR} \
        +app_update ${GAME_ID} \
        +quit
    fi
fi

echo "---Prepare Server---"
chmod -R 770 ${DATA_DIR}
echo "---Server ready---"

sleep infinity

echo "---Start Server---"
cd ${SERVER_DIR}
#!/bin/bash
cd /home/steam/wu

if [ -f ./server.cfg ]; then  
  source ./server.cfg
else  
  echo "Unable to find server.cfg file. Quitting like a coward."
  exit 1
fi

if [ -f WurmServerLauncher-patched ]; then  
  service_file='./WurmServerLauncher-patched'
else  
  service_file='./WurmServerLauncher'
fi

$service_file ADMINPWD="$ADMINPWD" EPICSETTINGS="$EPICSETTINGS" EXTERNALPORT="$EXTERNALPORT" HOMESERVER="$HOMESERVER" HOMEKINGDOM="$HOMEKINGDOM" LOGINSERVER="$LOGINSERVER" MAXPLAYERS="$MAXPLAYERS" QUERYPORT="$QUERYPORT" SERVERNAME="$SERVERNAME" SERVERPASSWORD="$SERVERPASSWORD" START="$START" IP="$IP"



