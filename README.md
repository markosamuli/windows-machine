# Windows Machine setup

## Windows

Make sure you're running Windows 10, version 1809 or newer.

Docker requires Hyper-V so you need Windows Pro license.

## Configure WinRM

Start WinRM service:

```PowerShell
winrm quickconfig
```

## Install dependencies

Set PSGallery as a trusted source for modules:

```PowerShell
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
```

Install NuGet provider:

```PowerShell
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
```

Install PowerShellGet and PackageManagement modules:

```PowerShell
Install-Module –Name PowerShellGet -Force -MinimumVersion 2.0.3
Install-Module –Name PackageManagement -Force -MinimumVersion 1.2.4
```

Install [cChoco module](https://www.powershellgallery.com/packages/cChoco/2.3.1.0):

```PowerShell
Install-Module -Name cChoco -MinimumVersion 2.4.0.0
```

## Developer Machine setup

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\DeveloperMachine.ps1
```

### Installed software

Configures following PowerShell package management sources:

* [NuGet](https://www.nuget.org)
* [PowerShell Gallery](https://www.powershellgallery.com)

Installs following PowerShell modules:

* [posh-git](https://github.com/dahlbyk/posh-git)

Enable following features:

* [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about) 

Install or upgrade the following software:

* Chocolatey 
* Chocolatey Core Extensions
* Chocolatey GUI
* Google Chrome 
* Firefox
* Cmder terminal application
* Postman for Windows
* Terraform
* Python 3.7.1
* Erlang
* Elixir 1.7.1
* Nodejs LTS 10.14.1
* Microsoft Visual C++ 2010 SP1 Redistributable Package
* GNU Privacy Guard for Windows
* 7zip
* Visual Studio Code
* OpenVPN client
* Spotify
* VLC media player

## Docker Desktop setup

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\DockerMachine.ps1
```

### Installed software

* Enable [Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/) feature
* Install Docker Desktop 

## PowerShell 5.1 Reference

* [PackageManagement](https://docs.microsoft.com/en-us/powershell/module/packagemanagement/?view=powershell-5.1)
* [PSDesiredStateConfiguration](https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/?view=powershell-5.1)
* [Built-In Windows PowerShell Desired State Configuration Resources](https://docs.microsoft.com/en-us/powershell/dsc/builtinresource)

## Troubleshooting

### The WMI service returned an 'access denied' error

When running `SetupMachine.ps1` script, you may see the following error:

```text
VERBOSE: Perform operation 'Invoke CimMethod' with following parameters, ''methodName' =
SendConfigurationApply,'className' = MSFT_DSCLocalConfigurationManager,'namespaceName' =
root/Microsoft/Windows/DesiredStateConfiguration'.
The WS-Management service cannot process the request. The WMI service returned an 'access denied' error.
    + CategoryInfo          : PermissionDenied: (root/Microsoft/...gurationManager:String) [], CimException
    + FullyQualifiedErrorId : HRESULT 0x80338104
    + PSComputerName        : localhost
```

**Solution:**

Make sure you start your PowerShell session with **Run as administrator** option.

### The request size exceeded the configured MaxEnvelopeSize quota

When running `SetupMachine.ps1` script, you may run into the following issue:

```text
VERBOSE: Perform operation 'Invoke CimMethod' with following parameters, ''methodName' =
SendConfigurationApply,'className' = MSFT_DSCLocalConfigurationManager,'namespaceName' =
root/Microsoft/Windows/DesiredStateConfiguration'.
The WinRM client sent a request to the remote WS-Management service and was notified that the request size exceeded
the configured MaxEnvelopeSize quota.
    + CategoryInfo          : LimitsExceeded: (root/Microsoft/...gurationManager:String) [], CimException
    + FullyQualifiedErrorId : HRESULT 0x80338111
    + PSComputerName        : localhost
```

**Solution:**

The [solution for this issue][1] is to increase the maximum envelope size, by running the following command in an elevated PowerShell session:

```PowerShell
Set-Item -Path WSMan:\localhost\MaxEnvelopeSizeKb -Value 2048
```

[1]: https://github.com/powershell/sharepointdsc/wiki/Error-Exceeded-the-configured-MaxEnvelopeSize-quota

### Script execution fails

Loading `SetupMachine.ps1` script fails:

```text
.\SetupMachine.ps1 : File C:\Users\babydragon\Documents\windows-machine\SetupMachine.ps1 cannot be loaded because
running scripts is disabled on this system. For more information, see about_Execution_Policies at
https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ .\SetupMachine.ps1
+ ~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
```

Change machine level PowerShell [ExecutionPolicy][2] to RemoteSigned in the CurrentUser scope:

```PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

### Execution Policy error when running DSC modules

cChoco modules fail to run:

```text
Importing module cChocoPackageInstall failed with error - File C:\Program
Files\WindowsPowerShell\Modules\cChoco\2.4.0.0\DscResources\cChocoPackageInstall\cChocoPackageInstall.psm1 cannot be loaded. The file C:\Program
Files\WindowsPowerShell\Modules\cChoco\2.4.0.0\DscResources\cChocoPackageInstall\cChocoPackageInstall.psm1 is not digitally signed.
```

**Solution:**

Change machine level PowerShell [ExecutionPolicy][2] to RemoteSigned in the LocalMachine scope:

```PowerShell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

[2]: https://docs.microsoft.com/en-gb/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-5.1

### Client cannot connect to the destination

You're seeing the following error when trying to run configuration scripts:

```text
The client cannot connect to the destination specified in the request. Verify that the service on the destination is running and is accepting requests.
Consult the logs and documentation for the WS-Management service running on the destination, most commonly IIS or WinRM.
```

**Solution:**

Configure WinRM.

### Hyper-V network detected as public prevents WinRM installation

You're seeing the following error when enabling WinRM and you have Hyper-V enabled:

```text
WinRM firewall exception will not work since one of the network connection types on this machine is set to Public. Change the network connection type to either Domain or Private and try again.
```

**Solution:**

Run following command to find the `InterfaceIndex` value:

```PowerShell
Get-NetConnectionProfile
```

Hyper-V network will show up as `Unidentified network`:

```text
Name             : Unidentified network
InterfaceAlias   : vEthernet (Default Switch)
InterfaceIndex   : 17
NetworkCategory  : Public
IPv4Connectivity : NoTraffic
IPv6Connectivity : NoTraffic
```

Change network category to Private using the correct `InterfaceIndex` value:

```PowerShell
Set-NetConnectionProfile -InterfaceIndex 17 -NetworkCategory Private
```