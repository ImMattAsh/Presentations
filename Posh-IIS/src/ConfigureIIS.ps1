#Add-PSSnapin WebAdministration -ErrorAction SilentlyContinue - for older OS's
Import-Module WebAdministration #-ErrorAction SilentlyContinue

Function CreateApplicationPool($appPoolConfig) {
    if(Test-Path "IIS:\AppPools\$($appPoolConfig.name)") {
        Write-Host "AppPool $($appPoolConfig.name) found - updating settings"
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

Function CreateApplication($appConfig) {
    if(Test-Path "IIS:\Sites\$($appConfig.parentSite)\$($appConfig.virtualPath)") {
        Write-Host "Found web application $($appConfig.virtualPath)"
    } else {
        Write-Host "Creating Web Application"
        New-WebApplication `
            -Name $appConfig.virtualPath `
            -Site $appConfig.parentSite `
            -PhysicalPath $appConfig.physicalPath `
            -ApplicationPool $appConfig.appPoolName
    }
}

Function CreateVirtualDirectory($vdConfig) {
    if(Test-Path "IIS:\Sites\$($vdConfig.parentSite)\$($vdConfig.application)\$($vdConfig.virtualPath)") {
        Write-Host "Found virtual directory $($vdConfig.virtualPath). Removing so it can be re-added"
        Remove-WebVirtualDirectory -Name $vdConfig.virtualPath -Site $vdConfig.parentSite -Application $vdConfig.application
    }

    Write-Host "Creating Web Virtual Directory"
    New-WebVirtualDirectory `
        -Name $vdConfig.virtualPath `
        -Site $vdConfig.parentSite `
        -PhysicalPath $vdConfig.physicalPath `
        -Application $vdConfig.application
}

Function ConfigureIIS {
    CreateApplicationPool $siteAppPoolConfig
    CreateApplicationPool $applicationAppPoolConfig
    CreateWebsite $websiteConfig
    CreateApplication $applicationConfig
    CreateVirtualDirectory $virtualDirectoryConfig
    CreateVirtualDirectory $applicationVirtualDirectoryConfig
}

. .\IISSettings.ps1 #pulling in configuration values to be used in this file
ConfigureIIS