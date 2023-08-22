# ParaBank Automation Project

Using Robot Framework, I have automated user processes and end-to-end flows for the site [ParaBank](https://parabank.parasoft.com/parabank/index.htm) using libraries like Selenium.

## Preconditions

A precondition for running the tests is having Robot Framework and SeleniumLibrary installed, which also requires Python. Robot Framework installation instructions cover both Robot and Python installations, and SeleniumLibrary has its own installation instructions.

You can install Robot Framework and SeleniumLibrary along with its dependencies using pip package manager. Once you have pip installed, all you need to do is run this command to obtain the rest of the project requirements:
```bash
pip install -r requirements.txt
```

## Installation
Clone the project with this URL:
```bash
https://github.com/emilyashburn/ParaBank-Automation.git
```


## Usage
In order to run the test cases, we need to select which test suite we want to run. For example, if you want to run the entire regression_PARA.robot suite:
```bash
robot Tests\regression_PARA.robot
```
Use this command if you want to only run the first test case in the regression_PARA.robot suite in FireFox:
```bash
robot -t *001* Tests\regression_PARA.robot
```

## Using different browsers
The browser that is used is controlled by ${browserType} variable defined in the Resource.robot resource file. Chrome browser is used by default, but that can be easily overridden from the command line:

```bash
robot --variable browserType:Chrome tests
robot --variable browserType:Firefox tests
```

## Tools & Notable Libraries

[![Generic badge](https://img.shields.io/badge/Python-3.10.10-<COLOR>.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/RobotFramework-6.0.2-<COLOR>.svg)](https://shields.io/)

Webdrivermanager (to autoupdate webdrivers for Chrome and FireFox) by [Rasjani](https://github.com/MarketSquare/webdrivermanager)

SeleniumLibrary by [robotframework.org](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
