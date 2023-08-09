#!/bin/bash

# Versions of the services
HLM_BACKEND_VERSION="3.4.0"

# Downloading
curl -L https://github.com/healenium/healenium-backend/releases/download/${HLM_BACKEND_VERSION}/healenium-backend-${HLM_BACKEND_VERSION}.jar > hlm-backend.jar

git clone https://github.com/healenium/healenium-selector-imitator.git
