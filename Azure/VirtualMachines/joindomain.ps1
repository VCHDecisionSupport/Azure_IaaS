
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