# cheapskate

Leverages the Azure CLI to automatically destroy [Deployment Stacks](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deployment-stacks?tabs=azure-powershell).

## Usage

Simply execute `cheapskate.ps1` in a pipeline that has been authenticated with Azure. 

This will destroy all deployment stacks within the subscription scope of the authenticated Azure identity.

```
- name: Delete stacks
  shell: pwsh
  run: ${{ github.workspace }}/cheapskate.ps1
```


## Excluding Stacks

Set an environment variable containing a JSON array when executing the script task.

These stacks will be skipped when the script runs.

```
- name: Delete stacks
  shell: pwsh
  run: ${{ github.workspace }}/cheapskate.ps1
  env:
    EXCLUDE_STACKS: |
      [ 'stack1', 'stack2' ]
```

## Limitations

Currently only destroys deployment stacks at the resource group level. Destroying subscription level deployment stacks is not supported.
