# Ansible 101

## Windows

Full docs can be found at [docs.ansible](https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html)

### Requirements

In order to establish a correct ansible setup, we need the following:

1. A controller machine to SSH to target machine
2. Target machines

If the host and target machines are Windows based the following requirements need to be met:

+ Ansible can manage desktop OSs including Windows 7, 8.1, and 10, and server OSs including Windows Server 2008, 2008 R2, 2012, 2012 R2, 2016, and 2019.
+ Ansible requires PowerShell 3.0 or newer and at least .NET 4.0 to be installed on the Windows host.
+ A WinRM listener should be created and activated. More details for this can be found below.


### Upgrade PowerShell and .Net Framework

```powershell
$url = "https://raw.githubusercontent.com/jborean93/ansible-windows/master/scripts/Upgrade-PowerShell.ps1"
$file = "$env:temp\Upgrade-PowerShell.ps1"
$username = "Administrator"
$password = "Password"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

# Version can be 3.0, 4.0 or 5.1
&$file -Version 5.1 -Username $username -Password $password -Verbose
```

Once completed, you will need to remove auto logon and set the execution policy back to the default of Restricted. You can do this with the following PowerShell commands:

```powershell
# This isn't needed but is a good security practice to complete
Set-ExecutionPolicy -ExecutionPolicy Restricted -Force

$reg_winlogon_path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $reg_winlogon_path -Name AutoAdminLogon -Value 0
Remove-ItemProperty -Path $reg_winlogon_path -Name DefaultUserName -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $reg_winlogon_path -Name DefaultPassword -ErrorAction SilentlyContinue
```

### WinRM Setup

```powershell
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file

# There are different switches and parameters (like -EnableCredSSP and -ForceNewSSLCert) that can be set
# alongside this script. The documentation for these options are located at the top of the script itself.
```

### WinRM Listener

The WinRM services listens for requests on one or more ports. Each of these ports must have a listener created and configured.

To view the current listeners that are running on the WinRM service, run the following command:

```powershell
winrm enumerate winrm/config/Listener
```

### Setup WinRM Listener

There are three ways to set up a WinRM listener:

Using winrm quickconfig for HTTP or winrm quickconfig -transport:https for HTTPS. This is the easiest option to use when running outside of a domain environment and a simple listener is required. Unlike the other options, this process also has the added benefit of opening up the Firewall for the ports required and starts the WinRM service.

Using Group Policy Objects. This is the best way to create a listener when the host is a member of a domain because the configuration is done automatically without any user input. For more information on group policy objects, see the Group Policy Objects documentation.

Using PowerShell to create the listener with a specific configuration. This can be done by running the following PowerShell commands:

```powershell
$selector_set = @{
    Address = "*"
    Transport = "HTTPS"
}
$value_set = @{
    CertificateThumbprint = "E6CDAA82EEAF2ECE8546E05DB7F3E01AA47D76CE"
}

New-WSManInstance -ResourceURI "winrm/config/Listener" -SelectorSet $selector_set -ValueSet $value_set
```



