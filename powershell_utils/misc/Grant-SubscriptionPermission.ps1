# https://docs.microsoft.com/en-us/azure/active-directory/role-based-access-control-manage-access-powershell

Set-Location $PSScriptRoot
$email = "victoria.guerrero.vch@outlook.com"
# Login-AzureRmAccount

Get-AzureRmRoleDefinition | FT Name, Description
(Get-AzureRmRoleDefinition "Virtual Machine Contributor").Actions
Get-AzureRmRoleAssignment -ResourceGroupName Pharma-Sales-ProjectForcast | FL DisplayName, RoleDefinitionName, Scope

Get-AzureSubscription
Get-AzureRmADServicePrincipal -SearchString "Owner"
New-AzureRmRoleAssignment -ObjectId "db44a2ac-0cfa-465f-941b-b6b54c399777" -RoleDefinitionName Owner -Scope "4830d36a-e5da-4f38-8647-b8ca702c1b1d"

# New-AzureRmRoleAssignment -SignInName <email of user> -RoleDefinitionName <role name in quotes> -ResourceGroupName <resource group name>

New-AzureRmRoleAssignment -Scope subscriptions/4830d36a-e5da-4f38-8647-b8ca702c1b1d -SignInName $email -RoleDefinitionName Owner

Get-AzureRmADGroup -SearchString "Owner"
