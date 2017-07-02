$ApplicationPoolName = ""
$Hostname = ""

Function CreateApplicationPool {

}

Function CreateWebsite {

}

Function BindToHostname {
    #append entry to hosts
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
