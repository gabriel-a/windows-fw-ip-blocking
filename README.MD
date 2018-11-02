# windows-fw-ip-blocking
Windows Firewall Script To block Spamhaus ip addresses

How to add Spamhuis in Windows Firewall with PowerShell.

- Step 1: Create a directory for working with PowerShell and PowerShell Scripts. Example - C:\ip-security

- Step 2: Type without quotes "PowerShell.exe -ExecutionPolicy Bypass" 
		- This will set the scripts Policy of PowerShell to run so that it can make the Windows FireWall Rules.

- Step 3: Run PowerShell and Administrator (right click PowerShell and select Run As Administrator).

- Step 5: Type without quotes "PowerShell.exe -ExecutionPolicy Bypass" 
		- This will set the scripts Policy of PowerShell to run so that it can make the Windows FireWall Rules.

- Step 6: Begin entering the Zones into your Windows FireWall. 
		Option 1 is for Older Versions of PowerShell. If Option 1 does not execute then use Option 2.

  - Option 1: Program.ps1

  - Option 2:.\Program.ps1

- Step 7: Just for precaution let's now set PowerShell back to Restricted Access on Scripts. 
		Type without quotes "PowerShell.exe -ExecutionPolicy Restricted".

That's it we are done... I suggest you keep your zone files so that you can update them easy by overwriting them. 
I would update them about Once a Month if you are experiencing attacks. 
Below is how you can remove the entries using the scripts and zone files.

 Option 1: Program.ps1

 Option 2:.\Program.ps1
 
## Built With

* Powershell - The language

## Authors

* **Gabriel Ajabahian** - *Initial work* - [gabriel-a](https://github.com/gabriel-a)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thanks to Jason Fossen (http://www.sans.org/windows-security/) This script is just a wrapper around his 
PowerShell automation script.