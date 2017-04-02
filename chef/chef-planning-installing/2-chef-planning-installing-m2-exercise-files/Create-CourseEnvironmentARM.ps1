Login-AzureRmAccount

function New-RandomString {
    $String = $null
    $r = New-Object System.Random
    1..6 | % { $String += [char]$r.next(97,122) }
    $string
}

### Define variables

$SubscriptionName = 'Microsoft Azure Enterprise'
$Location = 'canadacentral' ### Use "Get-AzureLocation | Where-Object Name -eq 'ResourceGroup' | Format-Table Name, LocationsString -Wrap" in ARM mode to find locations which support Resource Groups
$GroupName = 'chef-lab'
$DeploymentName = 'chef-server-deployment'
$StorageName = 'chefstorage' + (New-RandomString)
$PublicDNSName = 'chef-lab-' + (New-RandomString)
$AdminUsername = 'chef'

# ### Connect to Azure account

# if (Get-AzureSubscription){
#     Get-AzureSubscription -SubscriptionName $SubscriptionName | Select-AzureSubscription -Verbose
#     }
#     else {
#     Add-AzureAccount
#     Get-AzureSubscription -SubscriptionName $SubscriptionName | Select-AzureSubscription -Verbose
#     }

# # Switch-AzureMode AzureResourceManager -Verbose

### Create Resource Group ###

New-AzureRmResourceGroup -Name $GroupName -Location $Location -Verbose
$ResourceGroup = (Get-AzureRmResourceGroup -Name $GroupName)

# if((Get-AzureRmResourceGroup -ResourceGroupName $GroupName) -eq $false){
#     New-AzureRmResourceGroup -Name $GroupName -Location $Location -Verbose
#     $ResourceGroup = Get-AzureResourceGroup -Name $GroupName
#     }
#     else {$ResourceGroup = Get-AzureRmResourceGroup -Name $GroupName}

$parameters = @{
    'newStorageAccountName'="$StorageName";
    'adminUsername'="$AdminUsername";
    'dnsNameForPublicIP'="$PublicDNSName"
    }

# New-AzureResourceGroupDeployment `
New-AzureRmResourceGroupDeployment `
    -ResourceGroupName $ResourceGroup.ResourceGroupName `
    -Name $DeploymentName `
    -TemplateFile azuredeploy.json `
    -TemplateParameterObject $parameters `
    -Verbose
