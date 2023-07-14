#!/bin/bash

# Requirements hlm_backend
HLM_POSTGRES_DB=healenium
HLM_POSTGRES_SCHEMA=healenium
HLM_POSTGRES_USER=healenium_user
HLM_POSTGRES_PASSWORD=YDk2nmNs4s9aCP6K
HLM_COLLECT_METRICS=true
HLM_SERVER_PORT=7878
HLM_LOG_LEVEL=info

# Requirements hlm_proxy
RECOVERY_TRIES=1
SCORE_CAP=.6
HEAL_ENABLED=true
SELENIUM_SERVER_URL=http://localhost:4444
APPIUM_SERVER_URL=http://localhost:4723/wd/hub
HEALENIUM_SERVER_URL=http://localhost:7878
HEALENIUM_SERVICE=http://localhost:7878
IMITATE_SERVICE=http://localhost:8000

# Deploy the hlm-backend service
SPRING_POSTGRES_DB=$HLM_POSTGRES_DB SPRING_POSTGRES_SCHEMA=$HLM_POSTGRES_SCHEMA SPRING_POSTGRES_USER=$HLM_POSTGRES_USER SPRING_POSTGRES_PASSWORD=$HLM_POSTGRES_PASSWORD COLLECT_METRICS=$HLM_COLLECT_METRICS SPRING_SERVER_PORT=$HLM_SERVER_PORT HLM_LOG_LEVEL=$HLM_LOG_LEVEL java -jar hlm-backend.jar 2>&1 & echo $! > ./pid-hlm-backend.file &

# Deploy the hlm-proxy service
RECOVERY_TRIES=$RECOVERY_TRIES SCORE_CAP=$SCORE_CAP HEAL_ENABLED=$HEAL_ENABLED SELENIUM_SERVER_URL=$SELENIUM_SERVER_URL APPIUM_SERVER_URL=$APPIUM_SERVER_URL HEALENIUM_SERVER_URL=$HEALENIUM_SERVER_URL HEALENIUM_SERVICE=$HEALENIUM_SERVICE IMITATE_SERVICE=$IMITATE_SERVICE HLM_LOG_LEVEL=$HLM_LOG_LEVEL java -jar hlm-proxy.jar 2>&1 & echo $! > ./pid-hlm-proxy.file &

# Deploy the imitator service
pip install --upgrade pip

pip install -r healenium-selector-imitator/requirements.txt

if [[ $OSTYPE == 'msys'* ]];
then
  python healenium-selector-imitator/app.py & echo $! > ./pid-selector.file &
else
  python3 healenium-selector-imitator/app.py & echo $! > ./pid-selector.file &
fi
