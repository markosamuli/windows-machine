<#
.SYNOPSIS
Install software on development system.

.DESCRIPTION
Install software on development system.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration RubyDevelopmentMachine
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
        cChocoPackageInstaller installRuby
        {
            Name                 = 'ruby'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 2.6.1.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        
   }
}

RubyDevelopmentMachine
Start-DscConfiguration -Path .\RubyDevelopmentMachine -Wait -Verbose -Force