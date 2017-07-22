Import-Module WebAdministration

Function RemoveAppPool($appPoolName) {
    Write-Host "Removing app pool $appPoolName"
    Remove-WebAppPool -Name $appPoolName
}

Function RemoveWebSite($websiteName) {
    Write-Host "Removing site: $websiteName"
    Remove-Website -Name $websiteName
}

. .\IISSettings.ps1

RemoveWebSite $websiteConfig.name
RemoveAppPool $siteAppPoolConfig.name
RemoveAppPool $applicationAppPoolConfig.name