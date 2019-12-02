#!/usr/bin/env pwsh

Set-PSDebug -Trace 1

Install-WindowsFeature -name Web-Server -IncludeManagementTools

Set-PSDebug -Off
