# Healenium

[![Docker Pulls](https://img.shields.io/docker/pulls/healenium/hlm-backend.svg?maxAge=25920)](https://hub.docker.com/u/healenium)
[![License](https://img.shields.io/badge/license-Apache-brightgreen.svg)](https://www.apache.org/licenses/LICENSE-2.0)

### Table of Contents

[Overall information](#overall-information)

[Healenium installation](#healenium-installation)
* [Healenium with Mobitru](#run-healenium-with-mobitru)

[Language Examples](#language-examples)
* [Java](#java)
* [Python](#python)
* [C#](#c#)

### Overall information
Self-healing framework based on Selenium and able to use all Selenium supported languages like Java/Python/JS/C#
Healenium acts as proxy between client and selenium server.

`Docker-compose` includes the following services:
- `postgres-db` (PostgreSQL database to store etalon selector / healing / report)
- `hlm-proxy` (Proxy client request to Selenium server)
- `hlm-backend` (CRUD service)
- `selector imitator` (Convert healed locator to convenient format)
- `selenoid`/`selenium-grid` (Selenium server)

### Healenium installation

Clone Healenium repository:
```sh
git clone -b mobitru https://github.com/healenium/healenium.git
```

#### Run Healenium with Mobitru

> Note: `.env` consists of Mobitru credentials: PROJECT_NAME, API_KEY, APPIUM_HUB.
> Before run healenium you have to specify your own in the `.env`

Run healenium:
```sh
docker-compose up -d
```

### Language examples

```
    /**
    * "http://127.0.0.1:8085" OR "http://localhost:8085" if you are using locally running proxy server
    *
    * if you want to use a remote proxy server,
    * specify the ip address of this server - "http://remote_ip_address:8085"
    */
```

###### Java:
```java
    String nodeURL = "http://localhost:8085";

    options.setCapability("platformVersion", PLATFORM_VERSION);
    options.setCapability("browserName", BROWSER_NAME);
    options.setCapability("deviceName", DEVICE_NAME);

    AppiumDriver driver = new AndroidDriver(new URL(nodeURL), options);
```

###### Python
```py
    nodeURL = "http://localhost:8085"
    
    options.setCapability("platformVersion", PLATFORM_VERSION);
    options.setCapability("browserName", BROWSER_NAME);
    options.setCapability("deviceName", DEVICE_NAME);
    
    current_webdriver = webdriver.Remote(
        command_executor=nodeURL,
        options=options
    )
```

###### C#
```csharp
    String nodeURL = "http://localhost:8085";

    options.setCapability("platformVersion", PLATFORM_VERSION);
    options.setCapability("browserName", BROWSER_NAME);
    options.setCapability("deviceName", DEVICE_NAME);
    
    AppiumDriver driver = new AppiumDriver(new Uri(nodeURL), optionsChrome);
```


## Community / Support

* [Telegram chat](https://t.me/healenium)
* [GitHub Issues](https://github.com/healenium/healenium/issues)
* [YouTube Channel](https://www.youtube.com/channel/UCsZJ0ri-Hp7IA1A6Fgi4Hvg)
