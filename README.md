# healenium-proxy
Java project with healenium-proxy usage example.

Works with tests written in languages:

- [Java](#Java)
- [C#](#C#)
- [Python](#Python)
- [JavaScript](#JavaScript)

## How to start
### 1. Start docker compose file.
### 1.1 If you want work with Healenium and Selenoid UI
You must get docker-compose.yaml file by:

URL link:
```
https://raw.githubusercontent.com/healenium/healenium/master/docker-compose.yaml
```
cURL command:
```
curl https://raw.githubusercontent.com/healenium/healenium/master/docker-compose.yaml -o docker-compose.yaml
```
Additionally get browsers.json file by:

URL link:
```
https://raw.githubusercontent.com/healenium/healenium/master/docker-compose-selenium-v3.yaml
```
cURL command:
```
curl https://raw.githubusercontent.com/healenium/healenium/master/docker-compose-selenium-v3.yaml -o docker-compose-selenium-v3.yaml
```
### 1.2 If you want work with Healenium and Selenium Hub
You can get docker-compose.yaml file by cURL:</br>

<pre>
Files hierarchy:
    ˅ db
        ˅ sql
            init.sql
    docker-compose.yaml
</pre>
###In terminal go to the folder with <b>docker-compose.yaml</b> and run command `docker-compose up -d`
###    docker compose file contains modules (you can check them in docker Containers / Apps):
<pre>
    - postgres-db
      RUNNING PORT:5432

    - selector-imitator
      RUNNING PORT:8000

    - healenium
      RUNNING PORT:7878

    - hlm-proxy
      RUNNING PORT:8085

    - hlm-selenoid
      RUNNING PORT:4444
    
    - selenoid-ui
      RUNNING PORT:8080
</pre>
<a name="Java"></a> 
### <hr/>
### 2. Java usage example.
#### 2.1 Firefox usage example.
<pre>
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.testng.annotations.Test;

import java.net.MalformedURLException;
import java.net.URL;

public class ProxyUsageFirefox {

    static WebDriver driver;

    @Test(priority = 1)
    void setup() throws MalformedURLException {

        /**
         * "http://127.0.0.1:8085" OR "http://localhost:8085" if you are using locally running proxy server
         *
         * if you want to use a remote proxy server,
         * specify the ip address of this server - "http://remote_ip_address:8085"
         */
        String nodeURL = "http://localhost:8085";

        FirefoxOptions options = new FirefoxOptions();

        driver = new RemoteWebDriver(new URL(nodeURL), options);
    }
}

***
In any case, when you run stacktrace, you will see a link to the report.
But if you use the quit() method for your driver object, in the stack trace you will see
an additional link to the report at the end of the stack trace.

</pre>
#### 2.2 Chrome usage example.
<pre>
import org.openqa.selenium.By;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.testng.annotations.Test;

import java.net.MalformedURLException;
import java.net.URL;

public class ProxyUsageChrome {
    private static RemoteWebDriver driver;

    @Test(priority = 1)
    void setup() throws MalformedURLException {

        /**
         * "http://127.0.0.1:8085" OR "http://localhost:8085" if you are using locally running proxy server
         *
         * if you want to use a remote proxy server,
         * specify the ip address of this server - "http://remote_ip_address:8085"
         */
        String nodeURL = "http://localhost:8085";

        ChromeOptions options = new ChromeOptions();

        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");

        driver = new RemoteWebDriver(new URL(nodeURL), options);
    }
}

***
In any case, when you run stacktrace, you will see a link to the report.
But if you use the quit() method for your driver object, in the stack trace you will see
an additional link to the report at the end of the stack trace.

</pre>
<a name="C#"></a>
### <hr/>
### 3. C# usage example.
<pre>
Needs to import (Manage NuGet Packages...)
    - NUnit 3.13.2
    - NUnit.ConsoleRunner 3.12.0
    - NUnit3TestAdapter 4.0.0
    - RemoteWebDriverOptions 1.0.0
    - Selenium.WebDriver 3.141.0
    - Selenium.WebDriver.ChromeDriver 92.0.4515.10700
    - Selenium.WebDriver.GeckoDriver 0.29.1
    - Selenium.WebDriverBackedSelenium 3.141.0
</pre>
#### 3.1 Firefox usage example.
<pre>
using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Firefox;
using System;

namespace healenium_net {
    class ProxyUsageFirefox {
        RemoteWebDriver driverFirefox;

        /**
         * "http://127.0.0.1:8085" OR "http://localhost:8085" if you are using locally running proxy server
         *
         * if you want to use a remote proxy server,
         * specify the ip address of this server - "http://remote_ip_address:8085"
         */
        private readonly String nodeURL = "http://localhost:8085";

        [SetUp]
        public void Init() {
            FirefoxOptions optionsFirefox = new FirefoxOptions();
            driverFirefox = new RemoteWebDriver(new Uri(nodeURL), optionsFirefox);
        }
    }
}

***
In any case, when you run stacktrace, you will see a link to the report.
But if you use the quit() method for your driver object, in the stack trace you will see
an additional link to the report at the end of the stack trace.

</pre>
#### 3.2 Chrome usage example.
<pre>
using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Remote;
using System;

namespace healenium_net {
    class ProxyUsageChrome {
        RemoteWebDriver driverChrome;

        /**
         * "http://127.0.0.1:8085" OR "http://localhost:8085" if you are using locally running proxy server
         *
         * if you want to use a remote proxy server,
         * specify the ip address of this server - "http://remote_ip_address:8085"
         */
        private readonly String nodeURL = "http://localhost:8085";

        [SetUp]
        public void Init() {
            ChromeOptions optionsChrome = new ChromeOptions();
            optionsChrome.AddArguments("--no-sandbox");
            driverChrome = new RemoteWebDriver(new Uri(nodeURL), optionsChrome);
        }
    }
}

***
In any case, when you run stacktrace, you will see a link to the report.
But if you use the quit() method for your driver object, in the stack trace you will see
an additional link to the report at the end of the stack trace.

</pre>
<a name="Python"></a>
### <hr/>
### 4. Python usage example.
#### 4.1 Firefox usage example.
<pre>
from selenium import webdriver
from selenium.webdriver.common.by import By

# 
# "http://127.0.0.1:8085" OR "http://localhost:8085" if you are using locally running proxy server
#
# if you want to use a remote proxy server,
# specify the ip address of this server - "http://remote_ip_address:8085"
#
nodeURL = "http://localhost:8085"

def get_browser():
    options = webdriver.FirefoxOptions()
    browser = webdriver.Remote(
        command_executor=nodeURL,
        desired_capabilities=webdriver.DesiredCapabilities.FIREFOX,
        options=options,
    )
    return browser


current_webdriver = get_browser()

***
In any case, when you run stacktrace, you will see a link to the report.
But if you use the quit() method for your driver object, in the stack trace you will see
an additional link to the report at the end of the stack trace.

</pre>
#### 4.2 Chrome usage example.
<pre>
from selenium import webdriver
from selenium.webdriver.common.by import By

# 
# "http://127.0.0.1:8085" OR "http://localhost:8085" if you are using locally running proxy server
#
# if you want to use a remote proxy server,
# specify the ip address of this server - "http://remote_ip_address:8085"
#
nodeURL = "http://localhost:8085"

def get_browser():
    options = webdriver.ChromeOptions()
    options.add_argument('--no-sandbox')
    browser = webdriver.Remote(
        command_executor=nodeURL,
        desired_capabilities=webdriver.DesiredCapabilities.CHROME,
        options=options,
    )
    return browser


current_webdriver = get_browser()

***
In any case, when you run stacktrace, you will see a link to the report.
But if you use the quit() method for your driver object, in the stack trace you will see
an additional link to the report at the end of the stack trace.

</pre>
<a name="JavaScript"></a>
### <hr/>
### 5. JavaScript usage example.
#### 5.1 Firefox usage example.
<pre>
const {By,Key,Builder} = require("selenium-webdriver");

async function example() {
    /**
     * "http://127.0.0.1:8085" OR "http://localhost:8085" if you are using locally running proxy server
     *
     * if you want to use a remote proxy server,
     * specify the ip address of this server - "http://remote_ip_address:8085"
     */
    const NODE_URL = "http://localhost:8085";

    let driver = await new Builder().usingServer(NODE_URL).forBrowser("firefox").build();
}

example();

***
In any case, when you run stacktrace, you will see a link to the report.
But if you use the quit() method for your driver object, in the stack trace you will see
an additional link to the report at the end of the stack trace.

</pre>
#### 5.2 Chrome usage example.
<pre>
const {By,Key,Builder} = require("selenium-webdriver");
const selenium = require("selenium-webdriver");

async function example() {
    /**
     * "http://127.0.0.1:8085" OR "http://localhost:8085" if you are using locally running proxy server
     *
     * if you want to use a remote proxy server,
     * specify the ip address of this server - "http://remote_ip_address:8085"
     */
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
}

example();

***
In any case, when you run stacktrace, you will see a link to the report.
But if you use the quit() method for your driver object, in the stack trace you will see
an additional link to the report at the end of the stack trace.

</pre>

## Community / Support

* [Telegram chat](https://t.me/healenium)
* [GitHub Issues](https://github.com/healenium/healenium/issues)
* [YouTube Channel](https://www.youtube.com/channel/UCsZJ0ri-Hp7IA1A6Fgi4Hvg)
