# ParaBank Automation Project

Using Robot Framework, I have automated user processes and end-to-end flows for the site [ParaBank](https://parabank.parasoft.com/parabank/index.htm) using libraries like Selenium.

## Tools

[![Generic badge](https://img.shields.io/badge/Python-3.10.10-<COLOR>.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/RobotFramework-6.0.2-<COLOR>.svg)](https://shields.io/)

## Installation
- Clone this repository onto your computer and open a PowerShell window in that directory. I named my directory "parabankAutomation".
- To open a PowerShell window in a directory, be sure you're inside of your "parabankAutomation" folder and press ALT + SHIFT + RIGHT CLICK and click "Open PowerShell window here"

Use the package manager [pip](https://pip.pypa.io/en/stable/) in this PowerShell window to install all of the packages you need from the requirements.txt (last updated on 04/14/2023)

```bash
pip install -r requirements.txt
```

## Usage
In order to run the test cases, we need to select which test suite we want to run. For example, if you want to run the entire regression_PARA.robot suite:
```bash
robot suites\regression_PARA.robot
```
Use this command if you want to only run the first test case in the regression_PARA.robot suite:
```bash
robot -t *001* suites\regression_PARA.robot
```
