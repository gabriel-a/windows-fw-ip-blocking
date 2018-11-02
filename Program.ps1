####################################################################################
#.Synopsis 
#    Block all Spamhuis addresses listed in a text file using the Windows Firewall.
#
#.Description 
#    Script will create download the latest spamhaus file and import it to block those ranges on windows firewall
#
#.Example 
#    program.ps1 
#
#Requires -Version 1.0 
#
#.Notes 
#  Author: Gabriel Ajabahian (http://www.sans.org/windows-security/)  
# Version: 1.0
# Updated: 02.NOV.2018
#   LEGAL: PUBLIC DOMAIN.  SCRIPT PROVIDED "AS IS" WITH NO WARRANTIES OR GUARANTEES OF 
#          ANY KIND, INCLUDING BUT NOT LIMITED TO MERCHANTABILITY AND/OR FITNESS FOR
#          A PARTICULAR PURPOSE.  ALL RISKS OF DAMAGE REMAINS WITH THE USER, EVEN IF
#          THE AUTHOR, SUPPLIER OR DISTRIBUTOR HAS BEEN ADVISED OF THE POSSIBILITY OF
#          ANY SUCH DAMAGE.  IF YOUR STATE DOES NOT PERMIT THE COMPLETE LIMITATION OF
#          LIABILITY, THEN DELETE THIS FILE SINCE YOU ARE NOW PROHIBITED TO HAVE IT.
####################################################################################

$download_url = 'https://www.spamhaus.org/drop/drop.lasso'
$current_path = $PSScriptRoot
$block_script = Join-Path $current_path "Import-Firewall-Blocklist.ps1"

#Data related
$data_path = Join-Path $current_path "Data"
$input_path = Join-Path $data_path "drop.txt"
$output_file = Join-Path $data_path "spamhuis.txt"

#regex to retrieve IP addresses from spamhaus
$regex = '((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/(3[0-2]|[1-2][0-9]|[0-9])))'

####################################################################################
#    DONT UPDATE IF YOU DONT KNOW WHAT YOUR DOING
####################################################################################

If(!(test-path $data_path))
{
      New-Item -ItemType Directory -Force -Path $data_path
}

#Check file Last write time
if (Test-Path $output_file){
	$lastWrite = (get-item $output_file).LastWriteTime
	$timespan = new-timespan -hours 23 -minutes 0
	if (((get-date) - $lastWrite) -gt $timespan) {
		Write-Host "$output_file Last Write Time older than 1 day, script will download a new file."
	} else {
		Write-Host "$output_file update less than 24 hours ago"
		Break Script
	}
}

# Download the new file from spamhuis
Write-Host 'Starting Download'
Invoke-WebRequest -Uri $download_url -OutFile $input_path

Write-Host 'Starting the merge ' $output_file
if (Test-Path $output_file)
{
   Clear-Content $output_file
   Write-Host "Clearing content of $output_file"
}

Get-Content $input_path | ForEach-Object {
	$ip = [regex]::Matches($_, $regex).value
	if (-not ([string]::IsNullOrEmpty($ip)))
	{
		Add-Content $output_file $ip.Trim()
	}
}

Invoke-Expression "& `"$block_script`" -inputfile $output_file -deleteonly"
Invoke-Expression "& `"$block_script`" -inputfile $output_file"

if (Test-Path $input_path){
	Write-Host 'Removing path $input_path'
	Remove-Item -Path $input_path -Force
}
