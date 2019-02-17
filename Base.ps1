<#
.SYNOPSIS
Install software on developer machine.

.DESCRIPTION
Install software on developer machine.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration BaseMachine
{    
    Param (
        [switch]$AutoUpgrade
    )

    Import-DscResource -ModuleName cChoco -ModuleVersion 2.4.0.0
    Import-DscResource -ModuleName PackageManagement -ModuleVersion 1.2.4
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "localhost"
    {
        # PowerShell Package Management sources
        PackageManagementSource Nuget
        {
            Ensure      = "Present"
            Name        = "nuget.org"
            ProviderName= "NuGet"
            SourceLocation   = "https://api.nuget.org/v3/index.json"
            InstallationPolicy = "Trusted"
        }

        PackageManagementSource PSGallery
        {
            Ensure      = "Present"
            Name        = "PSGallery"
            ProviderName= "PowerShellGet"
            SourceLocation   = "https://www.powershellgallery.com/api/v2/"
            InstallationPolicy = "Trusted"
        }

        # PowerShell Packages
        PackageManagement Pester
        {
            Ensure               = "Present"
            Name                 = "Pester"
            Source               = "PSGallery"
            MinimumVersion       = 4.4.2
            DependsOn            = "[PackageManagementSource]PSGallery"
        }

        # Chocolatey packages
        cChocoinstaller Install {
            InstallDir = "C:\ProgramData\chocolatey"
        }
        cChocoPackageInstaller installChocolatey
        {
            Name                 = 'chocolatey'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 0.10.11
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installChocolateyCoreExtension
        {
            Name                 = 'chocolatey-core.extension'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.3.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installChocolateyGUI
        {
            Name                 = 'ChocolateyGUI'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 0.16.0
            DependsOn            = '[cChocoInstaller]Install'
        }

   }
}

BaseMachine
Start-DscConfiguration -Path .\BaseMachine -Wait -Verbose -Force