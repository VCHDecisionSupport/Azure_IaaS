$settings = '{
    "Name":"vch.ca",
    "User":"vch.ca\\Floater1",
    "Restart":"true",
    "Options":"3"
}'

$pwd = '{
    "Password":"Floater1"
}'

Set-AzureRmVMExtension -ResourceGroupName $env:resourceGroupName -ExtensionType "JsonADDomainExtension"`
    -Name "joindomain" -Publisher "Microsoft.Compute" -TypeHandlerVersion "1.3"`
    -VMName "JumpBoxVm1" -Location $env:dataCentre -SettingString $settings -ProtectedSettingString $pwd


$string1 = '{ 
   "Name": "vch", 
   "User": "vch\\Floater1", 
   "Restart": "true", 
   "Options": "3" 
        }'
$string2 = '{ "Password":"Floater1" }'

Set-AzureRmVMExtension -ResourceGroupName $env:resourceGroupName -ExtensionType "JsonADDomainExtension" `
    -Name "joindomain" -Publisher "Microsoft.Compute" -TypeHandlerVersion "1.0" `
    -VMName $VMName -Location $env:dataCentre -SettingString $string1 `
    -ProtectedSettingString $string2