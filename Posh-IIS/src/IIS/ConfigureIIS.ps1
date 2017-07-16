#Add-PSSnapin WebAdministration -ErrorAction SilentlyContinue - for older OS's
Import-Module WebAdministration #-ErrorAction SilentlyContinue

Function CreateApplicationPool($appPoolConfig) {
    if(Test-Path "IIS:\AppPools\$($appPoolConfig.name)") {
        Write-Host "AppPool $($appPoolConfig.name) found - will update settings"
    } else {
        Write-host "Creating app pool with name of '$($appPoolConfig.name)'"
        New-WebAppPool -Name $appPoolConfig.name
    }
    
    Set-ItemProperty -Path "IIS:\AppPools\$($appPoolConfig.name)" -name "managedRuntimeVersion" -value $appPoolConfig.managedRuntimeVersion
    Set-ItemProperty -Path "IIS:\AppPools\$($appPoolConfig.name)" -name "autoStart"             -value $appPoolConfig.autoStart
    Set-ItemProperty -Path "IIS:\AppPools\$($appPoolConfig.name)" -name "managedRuntimeVersion" -value $appPoolConfig.managedRuntimeVersion
    Set-ItemProperty -Path "IIS:\AppPools\$($appPoolConfig.name)" -name "processModel"          -value $appPoolConfig.processModel
   #Set-ItemProperty -Path "IIS:\AppPools\$($appPoolConfig.name)" -name processModel            -value @{userName="user_name";password="password";identitytype=3}
}

Function CreateWebsite($siteConfig) {
    if(Test-Path "IIS:\Sites\$($siteConfig.name)") {
        Write-Host "site '$($siteConfig.name)' already exists"
    } else {
        Write-Host "Creating Web Site"
        New-Website `
            -Name $siteConfig.name `
            -PhysicalPath $siteConfig.physicalPath `
            -HostHeader $siteConfig.hostName `
            -Port $siteConfig.port `
            -ApplicationPool $siteConfig.appPoolName
    }
}

Function BindToHostname {
    #append entry to hosts - NOT related to WebAdministration
    $hostPath = "C:\Windows\System32\drivers\etc\hosts"
    if(Select-String -path $hostPath -Pattern $hostName) {
        Write-host "Found host entry for $hostName"
    } else {
        Write-host "Adding host record found for $hostName"
        Add-content $hostPath "`r127.0.0.1`t`t`t$hostName"
    }
}

Function CreateApplication {
    Write-Host "Creating Web Application"
}

Function CreateVirtualDirectory {
    Write-Host "Creating Virtual Directory"
}

Function ConfigureIIS {
    CreateApplicationPool $siteAppPoolConfig
    CreateApplicationPool $applicationAppPoolConfig
    CreateWebsite $websiteConfig
    #BindToHostname
    #CreateApplication
    #CreateVirtualDirectory
}

. .\IISSettings.ps1 #pulling in configuration values to be used in this file
ConfigureIIS
#start-process "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://$hostName"
