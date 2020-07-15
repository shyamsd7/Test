$password = | ConvertTo-SecureString -asPlainText -Force
$username = "" 
New-Object System.Management.Automation.PSCredential($username,$password)
$computer = Read-Host "Enter a computer name"
get-wmiobject -cl Win32_PerfFormattedData_PerfProc_Process -ComputerName $computer -Credential $credential | ? {$_.Name -notlike '*_Total*' } | sort-object PercentPRocessorTime -desc | ft -auto Name,idprocess,percentprocessortime
$processnumber = Read-Host "Enter the process ID"
(Get-WmiObject Win32_Process -ComputerName $computer | ?{ $_.ProcessId -match $processnumber }).Terminate()