$resourcegroup = Read-Host -Prompt 'Enter the name of the resource group'
$storagename = Read-Host -Prompt 'Enter the name of the storage account'

Write-Host "Creating the following:"
Write-Host " == Resource Group: $resourcegroup" -ForegroundColor DarkGreen -BackgroundColor White
Write-Host " == Storage Account: $storagename" -ForegroundColor DarkGreen -BackgroundColor White
Write-Host " == Blob Container: tfstate" -ForegroundColor DarkGreen -BackgroundColor White
Write-Host "================================="
Write-Host "Using the following account:"
Write-Host "================================="
az account show

$response = Read-Host "Are you sure you want to continue? [y/N] " 
if ($response -eq "y" -or $response -eq "yes") {
  az group create --name "$resourcegroup" --location "southafricanorth" --tags 'Deployed By=Marco' 'Environment=Dev' 'Project=Terraform'
  if ( $? ) {
    Write-Host "=============================================="
    Write-Host "Resource Group Created"
    Write-Host "=============================================="
  }
  else {
    Write-Host "==============================================" -ForegroundColor DarkRed -BackgroundColor White
    Write-Host "Could Not Create Resource Group" -ForegroundColor DarkRed -BackgroundColor White
    Write-Host "==============================================" -ForegroundColor DarkRed -BackgroundColor White
    exit 1
  }

  az storage account create --name "$storagename" --resource-group "$resourcegroup" --tags 'Deployed By=Marco' 'Environment=Dev' 'Project=Terraform'
  if ( $? ) {
    Write-Host "=============================================="
    Write-Host "Storage Account Created"
    Write-Host "=============================================="
  }
  else {
    Write-Host "==============================================" -ForegroundColor DarkRed -BackgroundColor White
    Write-Host "Could Not Create Storage Account" -ForegroundColor DarkRed -BackgroundColor White
    Write-Host "==============================================" -ForegroundColor DarkRed -BackgroundColor White
    exit 1
  }
  
  az storage container create --name "tfstate" --account-name "$storagename" --auth-mode key
  if ( $? ) {
    Write-Host "=============================================="
    Write-Host "Container Created"
    Write-Host "=============================================="
  }
  else {
    Write-Host "==============================================" -ForegroundColor DarkRed -BackgroundColor White
    Write-Host "Could Not Create Container" -ForegroundColor DarkRed -BackgroundColor White
    Write-Host "==============================================" -ForegroundColor DarkRed -BackgroundColor White
    exit 1
  }
}