<#
.SYNOPSIS
Install software on development system.

.DESCRIPTION
Install software on development system.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration DevelopmentMachine
{
    Param (
        [switch]$AutoUpgrade
    )

    Import-DscResource -ModuleName cChoco -ModuleVersion 2.4.0.0
    Import-DscResource -ModuleName PackageManagement -ModuleVersion 1.2.4
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

        # Install developer tools
        cChocoPackageInstaller installMeld
        {
            Name                 = 'meld'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 3.20.0
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installCmder
        {
            Name                 = 'Cmder'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.3.11
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installPostman
        {
            Name                 = 'postman'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 7.0.6
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
        cChocoPackageInstaller installVCRedist2010
        {
            Name                 = 'vcredist2010'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 10.0.40219.2
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installBINDTools
        {
            Name                 = 'bind-toolsonly'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 9.12.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installJq
        {
            Name                 = 'jq'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.5
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installCmake
        {
            Name                 = 'cmake'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 3.14.1
            chocoParams          = '--installargs "ADD_CMAKE_TO_PATH=System"'
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installLLVM
        {
            Name                 = 'llvm'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 7.0.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installCURL
        {
            Name                 = 'curl'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 7.64.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installWget
        {
            Name                 = 'wget'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.20
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
        cChocoPackageInstaller installGitHubDesktop
        {
            Name                 = 'github-desktop'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.6.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installGitKraken
        {
            Name                 = 'gitkraken'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 4.2.2
            DependsOn            = '[cChocoInstaller]Install'
        }
   }
}

DevelopmentMachine
Start-DscConfiguration -Path .\DevelopmentMachine -Wait -Verbose -Force
