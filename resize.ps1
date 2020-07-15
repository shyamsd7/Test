$VDIs = Get-Content "C:\Windows\temp\UserRights.txt"

foreach ($VDI in $VDIs)
{
try
{
cd "C:\Users\BASEADMIN\Desktop"
.\PSExec.exe \\$VDI -s winrm.cmd quickconfig -quiet
Invoke-command -ComputerName $VDI -Credential $cred -ScriptBlock {Set-ItemProperty Path HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet -Name EnableActiveProbing -Value 0 -ErrorAction 'Stop'}
write-host "Done for $VDI"
}
catch
{
Write-Host "Error for VDI $VDI"
}

}