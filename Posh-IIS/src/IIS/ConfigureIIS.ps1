$siteAppPoolName = "IccSite.AppPool"
$applicationAppPoolName ="IccApp.AppPool"
$hostName = "IccSite.local"

Function CreateApplicationPool {

}

Function CreateWebsite {

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

}

Function CreateVirtualDirectory {

}

Function ConfigureIIS {
    CreateApplicationPool
    CreateWebsite
    BindToHostname
    CreateApplication
    CreateVirtualDirectory
}

ConfigureIIS
start-process "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "http://$hostName"
