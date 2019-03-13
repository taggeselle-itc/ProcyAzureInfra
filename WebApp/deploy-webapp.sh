#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

declare sku="F1"
declare resourceGroupLocation="West Europe"
declare resourcegroup="rg-procy-webapp"
declare webappname="ProcyWebApp"
declare appserviceplan="ProcyWebAppServicePlan"
declare database_name="ProcyDB"
declare password=""


# Initialize parameters specified from command line
while getopts ":s:l:r:a:f:d:p:" arg; do
	case "${arg}" in
		s)
			sku=${OPTARG}
			;;
		l)
			resourceGroupLocation=${OPTARG}
			;;
        r)
			resourcegroup=${OPTARG}
			;;
        a)
			webappname=${OPTARG}
			;;
        d)
			database_name=${OPTARG}
			;;
        f)
			appserviceplan=${OPTARG}
			;;
        p)
			password=${OPTARG}
			;;
		esac
done
shift $((OPTIND-1))

connectionString="Server=tcp:procydbserver.database.windows.net,1433;Initial Catalog=${database_name};Persist Security Info=False;User ID=ProcyUser;Password=${password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"

az group create --location $resourceGroupLocation --name $resourcegroup

az appservice plan create --name $appserviceplan --resource-group $resourcegroup --sku $sku

az webapp create --name $webappname --resource-group $resourcegroup --plan $appserviceplan

az webapp config connection-string set -g $resourcegroup -n $webappname -t SQLAzure --settings ProcyDbConnectionString=$connectionString
