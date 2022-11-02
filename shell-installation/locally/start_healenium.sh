#!/bin/bash

# Requirements hlm_backend
HLM_POSTGRES_DB=healenium
HLM_POSTGRES_SCHEMA=healenium
HLM_POSTGRES_USER=healenium_user
HLM_POSTGRES_PASSWORD=YDk2nmNs4s9aCP6K
HLM_SERVER_PORT=7878

# Deploy the services
SPRING_POSTGRES_DB=$HLM_POSTGRES_DB SPRING_POSTGRES_SCHEMA=$HLM_POSTGRES_SCHEMA SPRING_POSTGRES_USER=$HLM_POSTGRES_USER SPRING_POSTGRES_PASSWORD=$HLM_POSTGRES_PASSWORD SPRING_SERVER_PORT=$HLM_SERVER_PORT java -jar hlm-backend.jar 2>&1 &

pip install --upgrade pip

pip install -r healenium-selector-imitator/requirements.txt

if [[ $OSTYPE == 'msys'* ]];
then
  python healenium-selector-imitator/app.py
else
  python3 healenium-selector-imitator/app.py
fi
