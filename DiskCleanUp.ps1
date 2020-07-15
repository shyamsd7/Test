         function foldersize($folder) 
         { 
 
         $folderSizeinbyte = (Get-ChildItem $folder -Recurse | Measure-Object -property length -sum) 
   
         $folderSizeinMB=($folderSizeinbyte.sum / 1048576) 
  
         return $folderSizeinMB 
         } 
  
         
 
         function before($folder1) 
        { 
 
            $x=foldersize($folder1) 
            write-host "Total size before deletion=$x MB" 
            return $x 
        } 
 
         function post($folder2) 
        { 
 
            $y=foldersize($folder2) 
            write-host "Total size after deletion $y MB" 
            return $y 
        } 
  
        function msg($folder3) 
        { 
        write-Host "Removing Junk files in $folder3." -ForegroundColor Yellow -background black 
        } 
 
 
        
        function totalmsg($folder4,$sum) 
        { 
        write-Host "Total space cleared in MB from $folder4" $Sum  -ForegroundColor Green 
        } 
 
        function delete($folder5) 
        { 
 
            [double]$a=before($folder5) 
            msg($folder5) 
            Remove-Item -Recurse  $folder5 -Force -Verbose  
            [double]$b=post($folder5)  
 
            $total=$a-$b 
            totalmsg($folder5,$total) 
            $a=0 
            $b=0 
            $total=0 
        } 

 
   
    
        $objShell = New-Object -ComObject Shell.Application    
        $Recyclebin = $objShell.Namespace(0xA)      
        $temp = get-ChildItem "env:\TEMP"    
        $temp2 = $temp.Value    
        $WinTemp = "$env:SystemDrive\Windows\Temp\*"      
        $CBS="$env:SystemDrive\Windows\Logs\CBS\"  
        $swtools="$env:SystemDrive\swtools\*" 
        $drivers="$env:SystemDrive\drivers\*" 
        $swsetup="$env:SystemDrive\swsetup\*" 
        $downloads="$env:SystemDrive\users\administrator\downloads\*" 
        $Prefetch="$env:SystemDrive\Windows\Prefetch\*" 
        $DowloadeUpdate="$env:SystemDrive\Windows\SoftwareDistribution\Download\*" 
 
    
##Execution## 
     # Remove temp files located in "C:\Users\USERNAME\AppData\Local\Temp"    
        [double]$a=before($temp2) 
        msg($temp2) 
        Remove-Item -Recurse  "$temp2\*" -Force -Verbose  
        [double]$b=post($temp2)  
 
        $total=$a-$b 
        totalmsg($temp2,$total) 
 
     
    # Remove content of folder created during installation of driver     
        delete($swtools) 
     
 
    # Remove content of folder created during installation of Lenovo driver     
        delete($drivers) 
     
 
    # Remove content of folder created during installation of HP driver     
        delete($swsetup) 
 
    # Remove content of download folder of administrator account     
        delete($downloads)    
 
    # Empty Recycle Bin   
            write-Host "Emptying Recycle Bin." -ForegroundColor Cyan     
        $Recyclebin.items() | %{ remove-item $_.path -Recurse -verbose -Confirm:$false}    
 
 
    # Remove Windows Temp Directory  
        delete($WinTemp) 
    
 
 
    # Remove Prefetch folder content 
        delete($Prefetch) 
    
     
    # Remove CBS log file 
        #delete($CBS) 
     
 
    # Remove downloaded update 
        #delete($DowloadeUpdate) 
     
 
    #6# Running Disk Clean up Tool     
        write-Host "starting Windows disk Clean up Tool" -ForegroundColor Cyan    
        cleanmgr.exe /SAGESET:50 
        sleep 30 
        cleanmgr.exe /SAGERUN:50   
   
        write-Host "**Clean Up completed**" 
 