# https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps?view=azurermps-3.8.0#step-1-install-powershellget
$powershell_azurerm = Get-Module -Name AzureRM
$powershell_azurerm
if ($powershell_azurerm -eq $null) {
    Write-Host "`n`nPowerShell AzureRM module not installed/configured"
    $powershell_get = Get-Module PowerShellGet -list | Select-Object Name, Version, Path
    $powershell_get
    if ($powershell_get -eq $null) {
        $url = "https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps?view=azurermps-3.8.0#step-1-install-powershellget"
        Write-Host "`n`n*******************************************`n`ngo to `n`t$url`nand Upgrade to PowerShell 5`nopenning in browser..."
        Start-Sleep -Seconds 1
        Write-Host '`n`nand rerun this script to configure profile'
        Start-Process -FilePath $url
    }
    else {
        Write-Host 'PowerShellGet found... checking for AzureRM module'
        $powershell_azurerm = Get-Module AzureRM -list | Select-Object Name, Version, Path
        $powershell_azurerm
        if ($powershell_azurerm -eq $null) {
            Write-Host "`n`ninstalling AzureRM PowerShell module...`n"
            Start-Sleep -Seconds 1
            Install-Module AzureRM
        }
        else {
            Write-Host "`nAzureRM PowerShell found...`n"
            $powershell_azurerm = Get-Module AzureRM -list | Select-Object Name, Version, Path
            $powershell_azurerm
        }
        if (Test-Path -Path $profile) {
            New-Item -Path $profile
            $profile_content = Get-Content -Path $profile
            Add-Content -Path $profile -Value "`nImport-AzureRM`nLogin-AzureRmAccount`n"
        }
        Get-Module -Name AzureRM
    }
}
else {
    Write-Host "`n`nPowerShell seems configured to manage Azure"
}

Install-Module AzureAD