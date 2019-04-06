<#
.SYNOPSIS
Install Hyper-V and Docker Desktop on the target machine.

.DESCRIPTION
Install Hyper-V and Docker Desktop on the target machine.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>

Configuration DockerMachine
{
    Param (
        [switch]$AutoUpgrade
    )

    Import-DscResource -ModuleName cChoco -ModuleVersion 2.4.0.0
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "localhost"
    {
        # Windows features
        WindowsOptionalFeature HyperV
        {
            Ensure = 'Enable'
            Name = 'Microsoft-Hyper-V'
        }

        # Chocolatey packages
        cChocoinstaller Install {
            InstallDir = "C:\ProgramData\chocolatey"
        }
        cChocoPackageInstaller installDocker
        {
            Name                 = 'docker-desktop'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 2.0.0.3
            DependsOn            = '[cChocoInstaller]Install', '[WindowsOptionalFeature]HyperV'
        }
   }
}

DockerMachine
Start-DscConfiguration -Path .\DockerMachine -Wait -Verbose -Force
