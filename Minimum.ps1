<#
.SYNOPSIS
Install software on development system.

.DESCRIPTION
Install software on development system.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration MinimumMachine
{
    Param (
        [switch]$AutoUpgrade
    )

    Import-DscResource -ModuleName cChoco -ModuleVersion 2.4.0.0
    Import-DscResource -ModuleName PackageManagement -ModuleVersion 1.4.3
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "localhost"
    {

        PackageManagementSource PSGallery
        {
            Ensure      = "Present"
            Name        = "PSGallery"
            ProviderName= "PowerShellGet"
            SourceLocation   = "https://www.powershellgallery.com/api/v2/"
            InstallationPolicy = "Trusted"
        }
        PackageManagement PoshGit
        {
            Ensure               = "Present"
            Name                 = "posh-git"
            Source               = "PSGallery"
            MinimumVersion       = 0.7.3
            DependsOn            = "[PackageManagementSource]PSGallery"
        }

        WindowsOptionalFeature LinuxSubsystem
        {
            Ensure = 'Enable'
            Name = 'Microsoft-Windows-Subsystem-Linux'
        }

        # Chocolatey packages
        cChocoinstaller Install {
            InstallDir = "C:\ProgramData\chocolatey"
        }

        # Uninstall duplicate packages
        cChocoPackageInstaller installPoshGit
        {
            Name                 = 'poshgit'
            Ensure               = 'Absent'
            DependsOn            = '[cChocoInstaller]Install'
        }

        # Browsers
        cChocoPackageInstaller installChrome
        {
            Name                 = 'googlechrome'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 73.0.3683.103
            DependsOn            = '[cChocoInstaller]Install'
        }

        # Install developer tools
        cChocoPackageInstaller installMeld
        {
            Name                 = 'meld'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 3.20.0
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installVSCode
        {
            Name                 = 'vscode'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.33.0
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installGit
        {
            Name                 = 'git.install'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 2.21.0
            chocoParams          = '--params "/GitOnlyOnPath /NoAutoCrlf"'
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installTerminus
        {
            Name                 = 'terminus'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.0.73
            DependsOn            = '[cChocoInstaller]Install'
        }
   }
}

MinimumMachine
Start-DscConfiguration -Path .\MinimumMachine -Wait -Verbose -Force
