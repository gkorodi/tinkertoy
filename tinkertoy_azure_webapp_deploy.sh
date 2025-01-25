#!/bin/bash

APP_SERVICE_NAME="myPyApp"

deploy() {
	az webapp up --runtime PYTHON:3.12 --sku B1 --logs --name $APP_SERVICE_NAME
	# The `--runtime` parameter specifies what version of Python your app is running.
	# To list all available runtimes, use the command `az webapp list-runtimes --os linux --output table`.
	# The `--sku` parameter defines the size (CPU, memory) and cost of the app service plan. 
	# This example uses the B1 (Basic) service plan, which will incur a small cost in your Azure subscription. 
	# For a full list of App Service plans, view the App Service pricing page.
	# The `--logs`` flag configures default logging required to enable viewing the log stream immediately 
	# after launching the webapp.
	# You can optionally specify a name with the argument --name <app-name>. If you don't provide one, then 
	# a name will be automatically generated.
	# You can optionally include the argument --location <location-name> where <location_name> is an available 
	# Azure region. You can retrieve a list of allowable regions for your Azure account by running
	# the [az account list-locations](https://learn.microsoft.com/en-us/cli/azure/appservice#az-appservice-list-locations) command.
}

logConfig() {
	az webapp log config --web-server-logging filesystem --name $APP_SERVICE_NAME --resource-group $RESOURCE_GROUP_NAME
}

logTail() {
	az webapp log tail --name $APP_SERVICE_NAME --resource-group $RESOURCE_GROUP_NAME
}

deleteRG() {
	az group delete \
    --name gkorodi_rg_1445 # --no-wait
}
$*

