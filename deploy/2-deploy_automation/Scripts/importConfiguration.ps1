#Requires -Version 3.0
#Requires -Module AzureRM.Resources

Param(
	[Parameter(Mandatory=$true)]
    [string] $dscConfigFile,
	[Parameter(Mandatory=$true)]
    [string] $dscDataConfigFile,
	[string] $dscAutomationAccount,
	[string] $dscResourceGroup,
	[bool] $Force = $false
)
# import a configuration into Azure Automation account
Function Import-DscConfiguration ($dscConfigFile, $dscDataConfigFile, $dscAutomationAccount, $dscResourceGroup) {
	$dscConfigFileFull = (Get-Item $dscConfigFile).FullName
	$dscDataConfigFileFull = (Get-Item $dscDataConfigFile).FullName
	$dscConfigFileName = [io.path]::GetFileNameWithoutExtension($dscConfigFile)
	$dscDataConfigFileName = [io.path]::GetFileNameWithoutExtension($dscDataConfigFile)
	$dsc = Get-AzureRmAutomationDscConfiguration -ResourceGroupName $dscResourceGroup -AutomationAccountName $dscAutomationAccount -Name $dscConfigFileName -ErrorAction 'silentlycontinue' -Verbose 
	if ($dsc -and !$Force) { 
		Write-Information -MessageData  "Configuration $dscConfigFileName Already Exists"
	} else {
		Write-Information -MessageData  "Importing & compiling configuration $dscConfigFileName with config data $dscDataConfigFileName"
		Import-AzureRmAutomationDscConfiguration -AutomationAccountName $dscAutomationAccount -ResourceGroupName $dscResourceGroup -Published -SourcePath $dscConfigFileFull -Force -Verbose
        $dscDataConfigFileFullContent = (Get-Content $dscDataConfigFileFull | Out-String)
        Invoke-Expression $dscDataConfigFileFullContent
		$CompilationJob = Start-AzureRmAutomationDscCompilationJob -ResourceGroupName $dscResourceGroup -AutomationAccountName $dscAutomationAccount -ConfigurationName $dscConfigFileName -ConfigurationData $ConfigData -Verbose
		while($null -eq $CompilationJob.EndTime -and $null -eq $CompilationJob.Exception)           
		{
			$CompilationJob = $CompilationJob | Get-AzureRmAutomationDscCompilationJob
			Start-Sleep -Seconds 3
			Write-Information -MessageData "."
		}
		Write-Information -MessageData  "!"
		$CompilationJob | Get-AzureRmAutomationDscCompilationJobOutput
	}
}

Import-DscConfiguration $dscConfigFile $dscDataConfigFile $dscAutomationAccount $dscResourceGroup -Verbose