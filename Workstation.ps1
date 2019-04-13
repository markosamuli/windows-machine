<#
.SYNOPSIS
Install software on a workstation.

.DESCRIPTION
Install software on a workstation.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration WorkstationMachine
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
        cChocoPackageInstaller install7Zip
        {
            Name                 = '7zip'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 19.0.0
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installChrome
        {
            Name                 = 'googlechrome'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 73.0.3683.103
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installFirefox
        {
            Name                 = 'firefox'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 66.0.2
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller removeGPG4WinVanilla
        {
            Name                 = 'gpg4win-vanilla'
            Ensure               = 'Absent'
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installGPG4Win
        {
            Name                 = 'gpg4win'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 3.1.5
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installOpenVPN
        {
            Name                 = 'openvpn'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 2.4.7
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installVLC
        {
            Name                 = 'vlc'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 3.0.6
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installSpotify
        {
            Name                 = 'spotify'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.0.80.474
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installWinSCP
        {
            Name                 = 'winscp'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 5.15
            DependsOn            = '[cChocoInstaller]Install'
        }
   }
}

WorkstationMachine
Start-DscConfiguration -Path .\WorkstationMachine -Wait -Verbose -Force
