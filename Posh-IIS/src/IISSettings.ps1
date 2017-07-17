$siteAppPoolConfig = @{
    name = "IccSite.AppPool";
    managedRuntimeVersion = "v4.0";
    autoStart = $true;
    enable32BitAppOnWin64 = $true;
    processModel = @{
        identitytype = 4; #https://docs.microsoft.com/en-us/iis/configuration/system.applicationHost/applicationPools/add/processModel
    };
}

$applicationAppPoolConfig = @{
    name = "IccApp.AppPool";
    managedRuntimeVersion = "v2.0";
    autoStart = $false;
    enable32BitAppOnWin64 = $false;
    processModel = @{
        identitytype = 2; #https://docs.microsoft.com/en-us/iis/configuration/system.applicationHost/applicationPools/add/processModel
    };
}

$websiteConfig = @{
    name = "IccSite";
    physicalPath = "C:\temp\iccsite";
    port = 80;
    hostName = "iccsite.local";
    appPoolName = $siteAppPoolConfig.name;
}

$applicationConfig = @{
    virtualPath = "iccapp";
    physicalPath = "C:\temp\iccapp";
    appPoolName = $applicationAppPoolConfig.name;
    parentSite = $websiteConfig.name;
}

$virtualDirectoryConfig = @{
    virtualPath = "iccvd";
    physicalPath = "C:\temp\iccvd";
    parentSite = $websiteConfig.name;
    application = "";
}

$applicationVirtualDirectoryConfig = @{
    virtualPath = "iccappvd";
    physicalPath = "C:\temp\iccappvd";
    parentSite = $websiteConfig.name;
    application = $applicationConfig.virtualPath;
}