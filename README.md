# Healenium

[![Docker Pulls](https://img.shields.io/docker/pulls/healenium/hlm-backend.svg?maxAge=25920)](https://hub.docker.com/u/healenium)
[![License](https://img.shields.io/badge/license-Apache-brightgreen.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![@healenium](https://img.shields.io/badge/Telegram-%40healenium-orange.svg)](https://t.me/healenium)

### Table of Contents

[Overall information](#overall-information)

[Healenium installation](#healenium-installation)
* [Healenium with Selenium-Grid](#run-healenium-with-selenium-grid)
* [Healenium with Selenoid](#run-healenium-with-selenoid)
* [Healenium with Appium](#run-healenium-with-appium-only)

[Healenium installation without Docker](#healenium-installation-without-docker)

[Language Examples](#language-examples)
* [Java](#java)
* [Python](#python)
* [C#](#c#)
* [JavaScript](#javascript)

### Overall information
Self-healing framework based on Selenium and able to use all Selenium supported languages like Java/Python/JS/C#
Healenium acts as proxy between client and selenium server.

`Docker-compose` includes the following services:
- `postgres-db` (PostgreSQL database to store etalon selector / healing / report)
- `hlm-proxy` (Proxy client request to Selenium server)
- `hlm-backend` (CRUD service)
- `selector imitator` (Convert healed locator to convenient format)
- `selenoid`/`selenium-grid` (Selenium server)

<img width="977" alt="image" src="https://user-images.githubusercontent.com/69298932/230408855-11aefcb9-6e46-4c3a-a3da-bdad66a52a9c.png">


### Healenium installation

Clone Healenium repository:
```sh
git clone https://github.com/healenium/healenium.git
```

#### Run Healenium with Selenium-Grid:
```sh
docker-compose up -d
```

#### Run Healenium with Selenoid

> Note: `browsers.json` consists of target browsers and appropriate versions.
> Before run healenium you have to manually pull selenoid browser docker images with version specified in browsers.json

Example pull selenoid chrome image:
```sh
docker pull selenoid/vnc:chrome_111.0
```
Full list of browser images you can find [here](https://hub.docker.com/u/selenoid)


Run healenium with Selenoid:
```sh
docker-compose -f docker-compose-selenoid.yaml up -d
```

#### Run Healenium with Appium only

```sh
docker-compose -f docker-compose-appium.yaml up -d
```
More details about integration Healenium with Appium [here](https://github.com/healenium/healenium-appium)


### Healenium installation without Docker

Go to shell-installation:

```sh
cd shell-installatio
```

There are web and remote options to run healenium.

1. Start PostgeSql server.
- Create user (healenium_user/YDk2nmNs4s9aCP6K) (example data)
- Set attribute 'Can Login' (true) to user
- Create database (healenium) and set owner healenium_user
- Create schema (healenium) and set owner healenium_user

2. Specify your db user and password data in the bash script 'start_healenium.sh'.

3. Setup selenium server (selenium-grid)

Download healenium services
```sh
download_services.sh
```

Run shell command to launch healenium components 
```sh
start_healenium.sh
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

    ChromeOptions options = new ChromeOptions();
    options.addArguments("--no-sandbox");
    options.addArguments("--disable-dev-shm-usage");

    WebDriver driver = new RemoteWebDriver(new URL(nodeURL), options);
```

###### Python
```py
    nodeURL = "http://localhost:8085"
    
    options = webdriver.ChromeOptions()
    options.add_argument('--no-sandbox')
    
    current_webdriver = webdriver.Remote(
        command_executor=nodeURL,
        desired_capabilities=webdriver.DesiredCapabilities.CHROME,
        options=options,
    )
```

###### C#
```csharp
    String nodeURL = "http://localhost:8085";

    ChromeOptions optionsChrome = new ChromeOptions();
    optionsChrome.AddArguments("--no-sandbox");
    
    RemoteWebDriver driverChrome = new RemoteWebDriver(new Uri(nodeURL), optionsChrome);
```

###### JavaScript
```javascript
    const NODE_URL = "http://localhost:8085";

    let args = [
        "--no-sandbox"
    ];

    let chromeCapabilities = selenium.Capabilities.chrome()
        .set('chromeOptions', { args });

    let builder = new selenium.Builder()
        .forBrowser('chrome')
        .withCapabilities(chromeCapabilities);

    let driver = await builder.usingServer(NODE_URL).build();
```


## Community / Support

* [Telegram chat](https://t.me/healenium)
* [GitHub Issues](https://github.com/healenium/healenium/issues)
* [YouTube Channel](https://www.youtube.com/channel/UCsZJ0ri-Hp7IA1A6Fgi4Hvg)
