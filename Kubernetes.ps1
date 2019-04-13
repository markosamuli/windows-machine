<#
.SYNOPSIS
Install Hyper-V and Docker Desktop on the target machine.

.DESCRIPTION
Install Hyper-V and Docker Desktop on the target machine.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>

Configuration KubernetesMachine
{
    Param (
        [switch]$AutoUpgrade
    )

    Import-DscResource -ModuleName cChoco -ModuleVersion 2.4.0.0
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "localhost"
    {
        # Chocolatey packages
        cChocoinstaller Install {
            InstallDir = "C:\ProgramData\chocolatey"
        }
        cChocoPackageInstaller installKubernetesCLI
        {
            Name                 = 'kubernetes-cli'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.13.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        cChocoPackageInstaller installKubernetesHelm
        {
            Name                 = 'kubernetes-helm'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 2.13.1
            DependsOn            = '[cChocoInstaller]Install'
        }
   }
}

KubernetesMachine
Start-DscConfiguration -Path .\KubernetesMachine -Wait -Verbose -Force
