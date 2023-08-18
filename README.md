# ParaBank Automation Project

Using Robot Framework, I have automated user processes and end-to-end flows for the site [ParaBank](https://parabank.parasoft.com/parabank/index.htm) using libraries like Selenium.

## Tools & Notable Libraries

[![Generic badge](https://img.shields.io/badge/Python-3.10.10-<COLOR>.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/RobotFramework-6.0.2-<COLOR>.svg)](https://shields.io/)

Webdrivermanager (to autoupdate webdrivers for Chrome and FireFox) by [Rasjani](https://github.com/MarketSquare/webdrivermanager)

SeleniumLibrary by [robotframework.org](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)


## Installation
- Install PyCharm (this video can be helpful! https://youtu.be/srgZ3eQ6erw)
- Open PyCharm and select "Get From VCS" in order to clone this repo onto your machine.
- Paste this into the URL field, then click Clone
```bash
https://github.com/emilyashburn/ParaBank-Automation.git
```
- A Virtual Environment prompt will pop up. Select "OK" to create a Virtual Environment for the project.

  ✨ Now you have an exact copy of my working environment! ✨



## Usage
In order to run the test cases, we need to select which test suite we want to run. For example, if you want to run the entire regression_PARA.robot suite:
```bash
robot TestSuites\regression_PARA.robot
```
Use this command if you want to only run the first test case in the regression_PARA.robot suite in FireFox:
```bash
robot --variable browserType:firefox --variable -t *001* TestSuites\regression_PARA.robot
```
