<#
.SYNOPSIS
Install software on developer machine.

.DESCRIPTION
Install software on developer machine.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration DeveloperMachine
{
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
        cChocoPackageInstaller installChocolatey
        {
            Name                 = 'chocolatey'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 0.10.11
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installChocolateyCoreExtension
        {
            Name                 = 'chocolatey-core.extension'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 1.3.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installChocolateyGUI
        {
            Name                 = 'ChocolateyGUI'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 0.16.0
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installMeld
        {
            Name                 = 'meld'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 3.16.2
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installChrome
        {
            Name                 = 'googlechrome'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 72.0.3626.109
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installFirefox
        {
            Name                 = 'firefox'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 65.0.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installVLC
        {
            Name                 = 'vlc'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 3.0.6
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installSpotify
        {
            Name                 = 'spotify'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 1.0.80.474
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller install7Zip
        {
            Name                 = '7zip'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 18.6
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installCmder
        {
            Name                 = 'Cmder'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 1.3.11
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installPoshGit
        {
            Name                 = 'poshgit'
            Ensure               = 'Absent'
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installPostman
        {
            Name                 = 'postman'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 6.5.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installVSCode
        {
            Name                 = 'vscode'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 1.29.1
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installTerraform
        {
            Name                 = 'terraform'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 0.11.9
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installPython
        {
            Name                 = 'python3'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 3.7.1
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installNodejs
        {
            Name                 = 'nodejs-lts'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 10.14.1
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installErlang
        {
            Name                 = 'erlang'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 21.0.1.20180701
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installElixir
        {
            Name                 = 'Elixir'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 1.7.1
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installVCRedist2010
        {
            Name                 = 'vcredist2010'
            Ensure               = 'Present'
            AutoUpgrade          = $False
            Version              = 10.0.40219.2
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
            AutoUpgrade          = $True
            Version              = 3.1.5
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installOpenVPN
        {
            Name                 = 'openvpn'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 2.4.6.20180710
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installBINDTools
        {
            Name                 = 'bind-toolsonly'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 9.12.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installGolang
        {
            Name                 = 'golang'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 1.11.4
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installKubernetesCLI
        {
            Name                 = 'kubernetes-cli'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 1.13.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installKubernetesHelm
        {
            Name                 = 'kubernetes-helm'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 2.12.2
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installJq
        {
            Name                 = 'jq'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 1.5
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installCmake
        {
            Name                 = 'cmake'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 3.13.4
            chocoParams          = '--installargs "ADD_CMAKE_TO_PATH=System"'
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installLLVM
        {
            Name                 = 'llvm'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 7.0.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installCURL
        {
            Name                 = 'curl'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 7.64.0
            DependsOn            = '[cChocoInstaller]Install'
        }
        
        
   }
}

DeveloperMachine
Start-DscConfiguration -Path .\DeveloperMachine -Wait -Verbose -Force