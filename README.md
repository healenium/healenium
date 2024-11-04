# Healenium

[![Docker Pulls](https://img.shields.io/docker/pulls/healenium/hlm-backend.svg?maxAge=25920)](https://hub.docker.com/u/healenium)
[![License](https://img.shields.io/badge/license-Apache-brightgreen.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![@healenium](https://img.shields.io/badge/Telegram-%40healenium-orange.svg)](https://t.me/healenium)

### Table of Contents

[Overall information](#overall-information)

[Structure](#structure)

[Healenium installation](#healenium-installation)

[Configuration](#configuration)

[Disable Healing](#disable-healing)

[Report](#report)

[IDEA Plugin](#idea-plugin)

[Community](#community)

## Overall information
Self-healing framework based on Selenium and able to use all Selenium supported languages like Java/Python/JS/C#
Healenium acts as proxy between client and selenium server.

## Structure
Healenium includes the following services:
- `postgres-db` (PostgreSQL database to store reference selectors / healing / report)
- `hlm-proxy` (Proxying client requests to the Selenium server.)
- `hlm-backend` (CRUD service)
- `selector imitator` (Convert healed locator to convenient format)
- `selenoid`/`selenium-grid` (Selenium server)

<img width="977" alt="image" src="https://user-images.githubusercontent.com/69298932/230408855-11aefcb9-6e46-4c3a-a3da-bdad66a52a9c.png">


##### Healenium installation

Link to Docs


#### Configuration

Link to Docs

### Disable Healing

Link to Docs

## Report

Link to Docs

# IDEA Plugin

Link to Docs

###### Community

* [Telegram chat](https://t.me/healenium)
* [GitHub Issues](https://github.com/healenium/healenium/issues)
* [YouTube Channel](https://www.youtube.com/channel/UCsZJ0ri-Hp7IA1A6Fgi4Hvg)
