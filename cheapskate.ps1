# Get all the resource groups
$rgs = az group list --query "[].name" | ConvertFrom-Json

# Filter out the stacks that we don't want to delete
$excluded = $env:EXCLUDE_STACKS ?? "[]" | ConvertFrom-Json

# Get stacks in each resource group and delete them when not excluded
$stacks = $rgs | ForEach-Object {
  $rg = $_
  az stack group list --query "[].name" -g $rg | ConvertFrom-Json | ForEach-Object {
    If($_ -In $excluded) {
      Write-Host "Skipping stack '${_}' from resource group '${rg}' because it was excluded."
    }
    Else {
      Write-Host "Deleting stack '${_}' from resource group '${rg}'."
      az stack group delete --name $_ --resource-group $rg --aou deleteAll --yes
    }
  }
}
