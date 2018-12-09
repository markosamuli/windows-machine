Configuration SetupMachine
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

        # Windows features
        WindowsOptionalFeature HyperV
        {
            Ensure = 'Enable'
            Name = 'Microsoft-Hyper-V'
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
            AutoUpgrade          = $true
            Version              = 0.10.11
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installChocolateyCoreExtension
        {
            Name                 = 'chocolatey-core.extension'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 1.3.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installChocolateyGUI
        {
            Name                 = 'ChocolateyGUI'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 0.16.0
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installChrome
        {
            Name                 = 'googlechrome'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 71.10.3578.80
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installFirefox
        {
            Name                 = 'firefox'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 63.0.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installVLC
        {
            Name                 = 'vlc'
            Ensure               = 'Present'
            AutoUpgrade          = $false
            Version              = 3.0.4
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installSpotify
        {
            Name                 = 'spotify'
            Ensure               = 'Present'
            AutoUpgrade          = $false
            Version              = 1.0.80.474
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller install7Zip
        {
            Name                 = '7zip'
            Ensure               = 'Present'
            AutoUpgrade          = $false
            Version              = 18.5.0.20180730
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installCmder
        {
            Name                 = 'Cmder'
            Ensure               = 'Present'
            AutoUpgrade          = $false
            Version              = 1.3.5
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installPostGit
        {
            Name                 = 'poshgit'
            Ensure               = 'Absent'
            # AutoUpgrade          = $true
            # Version              = 0.7.3.1
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installPostman
        {
            Name                 = 'postman'
            Ensure               = 'Present'
            AutoUpgrade          = $false
            Version              = 6.5.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installVSCode
        {
            Name                 = 'vscode'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 1.29.1
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installTerraform
        {
            Name                 = 'terraform'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 0.11.9
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installPython
        {
            Name                 = 'python3'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 3.7.1
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installErlang
        {
            Name                 = 'erlang'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 21.0.1.20180701
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installNodejs
        {
            Name                 = 'nodejs-lts'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 10.14.1
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installElixir
        {
            Name                 = 'Elixir'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 1.7.1
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installVCRedist2010
        {
            Name                 = 'vcredist2010'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 10.0.40219.2
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installGPG4Win
        {
            Name                 = 'gpg4win-vanilla'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 2.3.4.20170919
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installOpenVPN
        {
            Name                 = 'openvpn'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 2.4.6.20180710
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installDocker
        {
            Name                 = 'docker-desktop'
            Ensure               = 'Present'
            AutoUpgrade          = $true
            Version              = 2.0.0.0
            DependsOn            = '[cChocoInstaller]Install', '[WindowsOptionalFeature]HyperV'
        }     
   }
}

SetupMachine
Start-DscConfiguration -Path  .\SetupMachine -Wait -Verbose -Force