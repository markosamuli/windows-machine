<#
.SYNOPSIS
Install software on development system.

.DESCRIPTION
Install software on development system.

.PARAMETER AutoUpgrade
Automatically upgrade packages installed with Chocolatey to their latest versions.
#>
Configuration ElixirDevelopmentMachine
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
        cChocoPackageInstaller installErlang
        {
            Name                 = 'erlang'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 21.2
            DependsOn            = '[cChocoInstaller]Install'
        } 
        cChocoPackageInstaller installElixir
        {
            Name                 = 'Elixir'
            Ensure               = 'Present'
            AutoUpgrade          = $AutoUpgrade
            Version              = 1.8.0
            DependsOn            = '[cChocoInstaller]Install'
        } 
        
   }
}

ElixirDevelopmentMachine
Start-DscConfiguration -Path .\ElixirDevelopmentMachine -Wait -Verbose -Force