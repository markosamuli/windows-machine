# Windows Machine setup

This is a collection of [Windows PowerShell Desired State Configuration] 
scripts I'm using on my Windows development workstation.

[Windows PowerShell Desired State Configuration]: https://docs.microsoft.com/en-us/powershell/dsc/overview/overview

## Windows 10

Make sure you're running [Windows 10 version 1809] or newer. These have not been
tested on other systems.

[Windows 10 version 1809]: https://docs.microsoft.com/en-us/windows/windows-10/release-information

## Configure WinRM

Start [WinRM] service:

```PowerShell
winrm quickconfig
```

[WinRM]: https://docs.microsoft.com/en-us/windows/desktop/winrm/portal

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

## Base setup

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Base.ps1
```

Configures following PowerShell package management sources:

* [NuGet]
* [PowerShell Gallery]

Install or upgrade the following software:

* [Chocolatey] 
* [Chocolatey Core Extensions]
* [Chocolatey GUI]

[NuGet]: https://www.nuget.org
[PowerShell Gallery]: https://www.powershellgallery.com
[Chocolatey]: https://chocolatey.org/
[Chocolatey Core Extensions]: https://chocolatey.org/packages/chocolatey-core.extension
[Chocolatey GUI]: https://github.com/chocolatey/ChocolateyGUI

## Workstation setup

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Workstation.ps1
```

Install or upgrade the following software:

* [Google Chrome] browser
* [Firefox] browser
* [OpenVPN] client
* [GNU Privacy Guard] for Windows
* [7zip] file archiver
* [Spotify]
* [VLC media player]

[Google Chrome]: https://www.google.com/chrome/
[Firefox]: https://www.mozilla.org/en-GB/firefox/new/
[OpenVPN]: https://openvpn.net/
[GNU Privacy Guard]: https://www.gnupg.org/
[7zip]: https://www.7-zip.org/
[Spotify]: https://www.spotify.com/
[VLC media player]: https://www.videolan.org/vlc/

## Development machine

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Development.ps1
```

Installs following PowerShell modules:

* [posh-git](https://github.com/dahlbyk/posh-git)

Enable following features:

* [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about) 

Install or upgrade the following software:

* [Meld] visual diff and merge tool
* [Cmder] console emulator
* [Postman] for Windows
* Microsoft Visual C++ 2010 SP1 Redistributable Package
* [Visual Studio Code]
* BIND Tools
* [jq] 1.5
* [CMake] tools 3.13.3
* [LLVM] compiler 7.0.1
* [GNU Wget]
* [Git] for Windows
* [GitHub Desktop]
* [GitKraken] Git Client

[Git]: https://git-scm.com/
[GNU Wget]: https://www.gnu.org/software/wget/
[LLVM]: https://llvm.org/
[jq]: https://stedolan.github.io/jq/
[CMake]: https://cmake.org/
[Cmder]: http://cmder.net/
[Meld]: http://meldmerge.org/
[Postman]: https://www.getpostman.com/
[Visual Studio Code]: https://code.visualstudio.com/
[GitHub Desktop]: https://desktop.github.com/
[GitKraken]: https://www.gitkraken.com/

### Go Programming language

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Golang.ps1
```

Install or upgrade the following software:

* [Go Programming Language] 1.11.5

[Go Programming Language]: https://golang.org/

### Cloud tools

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Cloud.ps1
```

Install or upgrade the following software:

* [Terraform] 0.11.11
* Kubernetes command-line tool, [kubectl] 1.13.3
* Kubernetes package manager, [Helm] 2.12.3

[Terraform]: https://www.terraform.io/
[kubectl]: https://kubernetes.io/docs/tasks/tools/install-kubectl/
[Helm]: https://helm.sh/

### Python development

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Python.ps1
```

Install or upgrade the following software:

* [Python] 3.7.2

[Python]: https://www.python.org/

### PHP development

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\PHP.ps1
```

Install or upgrade the following software:

* [PHP] 7.3.1
* [Composer] dependency manager for PHP

[PHP]: http://www.php.net/
[Composer]: https://getcomposer.org/

### Node.js development

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Node.ps1
```

Install or upgrade the following software:

* [Node.js] LTS 10.15.1

[Node.js]: https://nodejs.org/en/

### Ruby development

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Ruby.ps1
```

Install or upgrade the following software:

* [Ruby] 2.6.1.1

[Ruby]: https://www.ruby-lang.org/en/

### Elixir development

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Elixir.ps1
```

Install or upgrade the following software:

* [Erlang] 21.2
* [Elixir] v1.8

[Erlang]: http://www.erlang.org/
[Elixir]: https://elixir-lang.org/

### Docker for Windows setup

Docker for Windows requires [Hyper-V] so you need a Windows 10 Pro license.

Start PowerShell with **Run as administrator** option and run the following command:

```PowerShell
.\Docker.ps1
```

* Enable [Hyper-V] feature
* Install [Docker for Windows]

[Hyper-V]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/about/
[Docker for Windows]: https://docs.docker.com/docker-for-windows/
[Windows Pro]

## PowerShell 5.1 Reference

* [PackageManagement](https://docs.microsoft.com/en-us/powershell/module/packagemanagement/?view=powershell-5.1)
* [PSDesiredStateConfiguration](https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/?view=powershell-5.1)
* [Built-In Windows PowerShell Desired State Configuration Resources](https://docs.microsoft.com/en-us/powershell/dsc/builtinresource)

## Troubleshooting

See [Troubleshooting] document for common issues during configuration.

[Troubleshooting]: docs/troubleshooting.md

## License

* [MIT](LICENSE)

## Authors

* [@markosamuli](https://github.com/markosamuli)
