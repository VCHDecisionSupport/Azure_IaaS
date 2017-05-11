# Administer DNS on an Azure AD Domain Services managed domain
# https://azure.microsoft.com/en-us/documentation/articles/active-directory-ds-admin-guide-administer-dns/

# Azure AD Domain Services (Preview) - Create the 'AAD DC Administrators' group
# https://azure.microsoft.com/en-us/documentation/articles/active-directory-ds-getting-started/

# Administer an Azure Active Directory Domain Services managed domain
# https://azure.microsoft.com/en-us/documentation/articles/active-directory-ds-admin-guide-administer-domain/

# other readings
# https://azure.microsoft.com/en-us/documentation/articles/?product=active-directory-ds

Login-AzureRmAccount

import-module MSOnline

$msolcred = get-credential
connect-msolservice -credential $msolcred

Get-MsolGroup
Get-MsolDomain
Set-MsolDomain