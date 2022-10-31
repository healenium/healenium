#!/bin/bash

# Versions of the services
BACKEND_VERSION="3.2.4"

# Downloading
curl -L https://github.com/healenium/healenium-backend/releases/download/${BACKEND_VERSION}/healenium-backend.jar > hlm-backend.jar

git clone https://github.com/healenium/healenium-selector-imitator.git
