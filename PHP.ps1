<#
.SYNOPSIS
Install software on development system.

.DESCRIPTION
Install software on development system.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration PHPDevelopmentMachine
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
        cChocoPackageInstaller installPHP
        {
            Name                 = 'php'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 7.3.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installComposer
        {
            Name                 = 'composer'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 4.10.0
            DependsOn            = '[cChocoInstaller]Install'
        }
        
   }
}

PHPDevelopmentMachine
Start-DscConfiguration -Path .\PHPDevelopmentMachine -Wait -Verbose -Force