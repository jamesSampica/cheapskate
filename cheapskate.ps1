# Get all the resource groups
$rgs = az group list --query "[].name" | ConvertFrom-Json

# Filter out the resource groups that we don't want to delete
$excluded = $env:EXCLUDE_RGS | ConvertFrom-Json
$rgs = $rgs | Where-Object { $_ -NotIn $excluded }

# Get stacks in each resource group and delete them
$stacks = $rgs | ForEach-Object {
  $rg = $_
  az stack group list --query "[].name" -g $rg | ConvertFrom-Json | ForEach-Object {
    Write-Host "Deleting Stack ${_} from ${rg}"
    az stack group delete --name $_ --resource-group $rg --delete-resources --yes
  }
}
