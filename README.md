# cheapskate

Automatically destroy resources deployed to Azure.

Leverages [Deployment Stacks](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deployment-stacks?tabs=azure-powershell) through the Azure CLI.

## Usage

Simply execute `cheapskate.ps1` in a pipeline that has been authenticated with Azure.

```
- name: Delete stacks
  shell: pwsh
  run: ${{ github.workspace }}/cheapskate.ps1
```


## Excluding Stacks

Set an environment variable containing a JSON array when executing the script task.

```
- name: Delete stacks
  shell: pwsh
  run: ${{ github.workspace }}/cheapskate.ps1
  env:
    EXCLUDE_STACKS: "[ 'stack1', 'stack2' ]"
```
