<#
.SYNOPSIS
Install software on development system.

.DESCRIPTION
Install software on development system.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration PythonDevelopmentMachine
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
        cChocoPackageInstaller installPython
        {
            Name                 = 'python3'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 3.7.2
            DependsOn            = '[cChocoInstaller]Install'
        } 
        
   }
}

PythonDevelopmentMachine
Start-DscConfiguration -Path .\PythonDevelopmentMachine -Wait -Verbose -Force