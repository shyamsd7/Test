$days = 1
$system = Get-WmiObject win32_operatingsystem

if($system.ConvertToDateTime($system.LastBootUpTime) -lt (Get-Date).AddDays(-$days)){
    Restart-Computer -Force
}else{
    Write-Host "Machine was rebooted less than $days days ago"

}