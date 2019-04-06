<#
.SYNOPSIS
Install software on development system.

.DESCRIPTION
Install software on development system.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration PowerShellDevelopmentMachine
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
        cChocoPackageInstaller updateforUniversalCRuntimeinWindows 
        {
            Name                 = 'kb2999226'
            Ensure               = 'Present'
            Version              = 1.0.20181019
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installPowerShellCore
        {
            Name                 = 'powershell-core'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 6.1.3
            DependsOn            = '[cChocoInstaller]Install', '[cChocoPackageInstaller]updateforUniversalCRuntimeinWindows'
        }
        
   }
}

PowerShellDevelopmentMachine
Start-DscConfiguration -Path .\PowerShellDevelopmentMachine -Wait -Verbose -Force