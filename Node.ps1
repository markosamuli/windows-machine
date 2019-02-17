<#
.SYNOPSIS
Install Node.js on a development system.

.DESCRIPTION
Install Node.js on a development system.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration NodeDevelopmentMachine
{    
    Param (
        [switch]$AutoUpgrade
    ) 
    Import-DscResource -ModuleName cChoco -ModuleVersion 2.4.0.0
    Import-DscResource -ModuleName PackageManagement -ModuleVersion 1.2.4
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "localhost"
    {
        # Chocolatey packages
        cChocoinstaller Install {
            InstallDir = "C:\ProgramData\chocolatey"
        }
        cChocoPackageInstaller installNodejs
        {
            Name                 = 'nodejs-lts'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 10.15.1
            DependsOn            = '[cChocoInstaller]Install'
        } 
        
   }
}

NodeDevelopmentMachine
Start-DscConfiguration -Path .\NodeDevelopmentMachine -Wait -Verbose -Force