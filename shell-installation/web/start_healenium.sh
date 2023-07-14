#!/bin/bash

# Requirements hlm_backend
HLM_POSTGRES_DB=healenium
HLM_POSTGRES_SCHEMA=healenium
HLM_POSTGRES_USER=healenium_user
HLM_POSTGRES_PASSWORD=YDk2nmNs4s9aCP6K
HLM_COLLECT_METRICS=true
HLM_SERVER_PORT=7878
HLM_LOG_LEVEL=info

# Deploy the hlm-backend service
SPRING_POSTGRES_DB=$HLM_POSTGRES_DB SPRING_POSTGRES_SCHEMA=$HLM_POSTGRES_SCHEMA SPRING_POSTGRES_USER=$HLM_POSTGRES_USER SPRING_POSTGRES_PASSWORD=$HLM_POSTGRES_PASSWORD COLLECT_METRICS=$HLM_COLLECT_METRICS SPRING_SERVER_PORT=$HLM_SERVER_PORT HLM_LOG_LEVEL=$HLM_LOG_LEVEL java -jar hlm-backend.jar 2>&1 & echo $! > ./pid-hlm-backend.file &

# Deploy the imitator service
pip install --upgrade pip

pip install -r healenium-selector-imitator/requirements.txt

if [[ $OSTYPE == 'msys'* ]];
then
  python healenium-selector-imitator/app.py & echo $! > ./pid-selector.file &
else
  python3 healenium-selector-imitator/app.py & echo $! > ./pid-selector.file &
fi
