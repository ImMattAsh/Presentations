$dnsConfig = @{
    hostName = "IccSite.local";
    port = 80;
}

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
    physicalPath = "C:\users\mash\github\Presentations\Posh-IIS\src\Apps\IowaCodeCamp\IowaCodeCamp.Site";
    port = $dnsConfig.port;
    hostName = $dnsConfig.hostName;
    appPoolName = $siteAppPoolConfig.name;
}

