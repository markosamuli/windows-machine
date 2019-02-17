<#
.SYNOPSIS
Install software on development system.

.DESCRIPTION
Install software on development system.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration CloudDevelopmentMachine
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
        cChocoPackageInstaller installTerraform
        {
            Name                 = 'terraform'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 0.11.11
            DependsOn            = '[cChocoInstaller]Install'
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
            Version              = 2.12.3
            DependsOn            = '[cChocoInstaller]Install'
        }
        
   }
}

CloudDevelopmentMachine
Start-DscConfiguration -Path .\CloudDevelopmentMachine -Wait -Verbose -Force