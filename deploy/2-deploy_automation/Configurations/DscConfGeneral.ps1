Configuration DscConfGeneral
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'xDSCDomainjoin'
    Import-DscResource -ModuleName xActiveDirectory, xStorage, PSDesiredStateConfiguration
    $dscDomainAdmin = Get-AutomationPSCredential -Name 'addcDomainAdmin'
    $dscDomainName = Get-AutomationVariable -Name 'addcDomainName'

    node $AllNodes.NodeName
    {
        xWaitforDisk Disk2 
        {
            DiskNumber = 2
            RetryIntervalSec = 20
            RetryCount = 30
        }

        xDisk GeneralDataDisk 
        {
            DiskNumber = 2
            DriveLetter = "D"
            DependsOn = "[xWaitForDisk]Disk2"
        }
        xDSCDomainjoin JoinDomain
        {
            Domain = $dscDomainName 
            Credential = $dscDomainAdmin
        }
    }
}