# Get all the resource groups
$rgs = az group list --query "[].name" | ConvertFrom-Json

# Filter out the resource groups that we don't want to delete
$excluded = $env:EXCLUDE_STACKS ?? "[]" | ConvertFrom-Json

# Get stacks in each resource group and delete them
$stacks = $rgs | ForEach-Object {
  $rg = $_
  az stack group list --query "[].name" -g $rg | ConvertFrom-Json | ForEach-Object {
    If($_ -In $excluded) {
      Write-Host "Skipping Stack ${_} from ${rg}"
    }
    Else {
      Write-Host "Deleting Stack ${_} from ${rg}"
      az stack group delete --name $_ --resource-group $rg --delete-resources --yes
    }
  }
}
