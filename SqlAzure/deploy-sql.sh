#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

declare env="dev"
declare resourceGroupLocation="West Europe"
declare resourcegroup="rg-procy-sql"
declare database_name="ProcyDB"
declare server="procydbserver"
declare password=""

# Initialize parameters specified from command line
while getopts ":e:l:r:d:s:p:" arg; do
	case "${arg}" in
		e)
			env=${OPTARG}
			;;
		l)
			resourceGroupLocation=${OPTARG}
			;;
        r)
			resourcegroup=${OPTARG}
			;;
        d)
			database_name=${OPTARG}
			;;
		s)
			server=${OPTARG}
			;;
        p)
			password=${OPTARG}
			;;
		esac
done
shift $((OPTIND-1))

#create resource group
az group create --name ${resourcegroup} --location ${resourceGroupLocation}

#create deployment for sepecific given environment
az group deployment create --resource-group ${resourcegroup} --template-file azuredeploy.json --parameters @$env.parameters.json --parameters database_name=$database_name --parameters server_name=$server --parameters sqlserveradminpw=$password