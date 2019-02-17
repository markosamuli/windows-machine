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
        cChocoPackageInstaller installChrome
        {
            Name                 = 'googlechrome'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 72.0.3626.109
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installFirefox
        {
            Name                 = 'firefox'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 65.0.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller install7Zip
        {
            Name                 = '7zip'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 18.6
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
            Version              = 2.4.6.20190116
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
        
   }
}

WorkstationMachine
Start-DscConfiguration -Path .\WorkstationMachine -Wait -Verbose -Force