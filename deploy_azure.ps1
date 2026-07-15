param(
  [string]$resourceGroup = "sajin-portfolio-rg",
  [string]$location = "eastus",
  [string]$appName = "sajin-portfolio-app"
)

Write-Host "Preparing deployment to Azure App Service..."

# Login (uncomment if needed)
# az login

Write-Host "Creating resource group $resourceGroup in $location"
az group create --name $resourceGroup --location $location

Write-Host "Creating App Service plan (Linux, B1)"
az appservice plan create --name "${appName}-plan" --resource-group $resourceGroup --is-linux --sku B1

Write-Host "Creating web app $appName"
az webapp create --resource-group $resourceGroup --plan "${appName}-plan" --name $appName --runtime "PYTHON|3.10"

Write-Host "Configure startup command to use gunicorn"
az webapp config set --resource-group $resourceGroup --name $appName --startup-file "gunicorn --bind 0.0.0.0 --timeout 600 app:app"

Write-Host "Deploying the app as a zip (this compresses current folder)", "This may take a few minutes..."
$zip = Join-Path $PWD "app-deploy.zip"
if(Test-Path $zip){ Remove-Item $zip }
Compress-Archive -Path * -DestinationPath $zip -Force

az webapp deploy --resource-group $resourceGroup --name $appName --src-path $zip --type zip

Write-Host "Deployment finished. Browse to https://$appName.azurewebsites.net"