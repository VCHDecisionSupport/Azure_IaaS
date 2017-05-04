$ConfigData = @{
    AllNodes = @(
        @{
            NodeName = "General"
            PSDscAllowPlainTextPassword = $True
			PSDscAllowDomainUser = $True
        }
    )
}
