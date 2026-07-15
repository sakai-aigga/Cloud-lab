# Simple Chatbot

This is a minimal chatbot with a Flask backend and a static frontend.

## Run (Windows)

Create a virtual environment, install dependencies, and run:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r "requirements.txt"
python app.py
```

Then open http://localhost:5000 in your browser.

## Deploy to Azure App Service (Linux)

Prerequisites: [Azure CLI installed](https://learn.microsoft.com/cli/azure/install-azure-cli) and you're logged in (`az login`).

Quick deploy (PowerShell):

```powershell
# Edit values as needed
.
.
.\deploy_azure.ps1 -resourceGroup "sajin-portfolio-rg" -location "eastus" -appName "sajin-portfolio-app"
```

What the script does:
- Creates a resource group and App Service plan (Linux)
- Creates a Python web app and sets the startup command to run `gunicorn`
- Zips the project and deploys it to the web app

Notes:
- Replace `sajin-portfolio-app` with a globally unique name for your app.
- You can also deploy via `az webapp up` or use GitHub Actions for CI/CD.
