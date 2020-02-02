
#put ypur want to copy Remote location
$RemotePath131 = "\\amknt131\tibco_logs\LotTracking_20191128\"
$RemotePath132 = "\\amknt132\tibco_logs\LotTracking_20191128\"


#put copy to your laptop location 
$targetFolder = "C:\AAA\1\"  

#if you don't input Start and End Date and then auto point Today
$StartDate =  (Read-Host -Prompt 'Enter the start date of the logs, Ex: 11/28/2019 or 11/27/2019 07:41 AM')
if($StartDate -eq ''){
   $StartDate = Get-Date 
}
else{
   $StartDate = Get-Date $StartDate 
}
$EndDate = (Read-Host -Prompt 'Enter the   End  date of the logs,  Ex: 12/03/2019 or 11/28/2019 04:33 AM') 

if($EndDate -eq ''){
   $EndDate = Get-Date 
}
else{
   $EndDate = Get-Date $EndDate 
}  

write-host "Your StartDate is "  $StartDate
write-host "Your EndDate is "$EndDate
write-host "=========================================================="
$tempdate=Get-Date
write-host "Start to copy files" $tempdate 
$filecounter = 0
Foreach($file in (Get-ChildItem $RemotePath)) {

    #If($StartDate.DateTime -le $file.LastWriteTime -and $EndDate.DateTime -ge  $file.LastWriteTime) 
     If($file.LastWriteTime -ge $StartDate.DateTime -and $file.LastWriteTime -le $EndDate.DateTime ) 
    {         
        if (!(Test-path (join-path $targetFolder $file.name)))
        {
           Copy-Item -Path $file.fullname -Destination $targetFolder
           $filecounter ++
           write-host $file.Name " " $file.LastWriteTime
        }
    }
}

$tempdate=Get-Date
write-host "Copy files compile!!!!" $tempdate  " Total files:"  $filecounter
Read-Host -Prompt "Press Enter to continue!!!"