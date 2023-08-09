#!/bin/bash

# Versions of the services
HLM_BACKEND_VERSION="3.4.0"
HLM_PROXY_VERSION="1.3.5"

# Downloading
curl -L https://github.com/healenium/healenium-backend/releases/download/${HLM_BACKEND_VERSION}/healenium-backend-${HLM_BACKEND_VERSION}.jar > hlm-backend.jar

curl -L https://github.com/healenium/healenium-proxy/releases/download/${HLM_PROXY_VERSION}/hlm-proxy-${HLM_PROXY_VERSION}.jar > hlm-proxy.jar

git clone https://github.com/healenium/healenium-selector-imitator.git
