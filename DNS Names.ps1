ForEach ($computer in (Get-Content C:\Windows\Temp\servers.txt)) {
    Try {
        [net.dns]::GetHostEntry($Computer).Hostname | Out-File -FilePath C:\Windows\Temp\servers1.txt -Append
    } 
    Catch {
        "$Computer Unable to find" | Out-File -FilePath C:\Windows\Temp\servers1.txt -Append
    }
}