# Copyright (c) 2017 Chocolatey Software, Inc.
# Copyright (c) 2013 - 2017 Lawrence Gripper & original authors/contributors from https://github.com/chocolatey/cChoco
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Configuration SetupMachine
{
   Import-DscResource -Module cChoco
   Node "localhost"
   {
       
        # Install Chocolatey 
        cChocoPackageInstaller installChocolatey
        {
            Name                 = 'chocolatey'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 0.10.11
        }
       
        # Install Chocolatey Core Extensions
        cChocoPackageInstaller installChocolateyCoreExtension
        {
            Name                 = 'chocolatey-core.extension'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 1.3.3
        }

        # Install Chocolatey GUI
        cChocoPackageInstaller installChocolateyGUI
        {
            Name                 = 'ChocolateyGUI'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 0.16.0
        }

        # Install Cmder terminal application
        cChocoPackageInstaller installCmder
        {
            Name                 = 'Cmder'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 1.3.10
        }

        # Install Postman for Windows
        cChocoPackageInstaller installPostman
        {
            Name                 = 'postman'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 6.5.3
        }

        # Install Terraform
        cChocoPackageInstaller installTerraform
        {
            Name                 = 'terraform'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 0.11.9
        }

        # Install Python 3.7
        cChocoPackageInstaller installPython
        {
            Name                 = 'python3'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 3.7.1
        } 

        # Install Erlang
        cChocoPackageInstaller installErlang
        {
            Name                 = 'erlang'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 21.0.1.20180701
        } 

        # Install Elixir programming language
        cChocoPackageInstaller installElixir
        {
            Name                 = 'Elixir'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 1.7.1
        } 

        # The Microsoft Visual C++ 2010 SP1 Redistributable Package (x86 & x64) 
        # installs runtime components of Visual C++ Libraries required to run 
        # 64-bit and 32-bit applications developed with Visual C++ SP1 on a 
        # computer that does not have Visual C++ 2010 SP1 installed.
        cChocoPackageInstaller installVCRedist2010
        {
            Name                 = 'vcredist2010'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 10.0.40219.2
        }

        # Gpg4win-vanilla (GNU Privacy Guard for Windows) only 
        # installs the actual file encryption and digital signature 
        # command-line tool gpg.exe.
        cChocoPackageInstaller installGPG4Win
        {
            Name                 = 'gpg4win-vanilla'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 2.3.4.20170919
        }

        # Install OpenVPN client
        cChocoPackageInstaller installOpenVPN
        {
            Name                 = 'openvpn'
            Ensure               = 'Present'
            AutoUpgrade          = $True
            Version              = 2.4.6.20180710
        }
   }
}

SetupMachine

Start-DscConfiguration .\SetupMachine -Wait -Verbose -Force