# ProcyAzureInfra 

<img src="misc/procy-logo.png" width="50">

This repo contains templates and resource files to create Procy Backend infrastructure in Azure. The main components of Procy Backend consist of different Web Services connected to a Database within an SQL Server.

Therefore this repo provides different scripts for provisioning an SQL Server including at least one database and an Azure App Service Plan including at least one App Service. Furthermore a connection string will be placed as connection setting to the Azure Web App.

If the Script will be executed with an existing SqlServer but another database name, a new database will be created related to the existing server. The same goes for the Azure App Service Plan and all related WebApps. So one App Service Plan can contain multiple WebApps. 

Before you can run the scripts you need to login into MS Azure with the `az login` command.

**Create the Sql Azure Infrastructure**

`sh SqlAzure/deploy-sql.sh -e basic -d {YourDatabaseName} -p {YourPassword}`

**Create the Sql Azure Web App**

Datbasename and Password must correspond to the SQL Azure settings to create the correct connection string.

`sh WebApp/deploy-webapp.sh -d {YourDatabaseName} -p {YourPassword} -ap {AppServicePanName} -a {WebAppName}`