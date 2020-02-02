
#Set-Location "\\amknt132\tibco_logs"

#put ypur want to copy Remote location
$RemotePath = "\\amknt132\tibco_logs\"

#put copy to your laptop location must create by yourself
$targetFolder = "C:\AAA\ProductionLogs\LotTracking\" 
  
hello-world
#if you don't input Start and End Date and then auto point Today
#cause nightshift logs acorss 2days and I define $TStartDate -1 and $TEndDate +1 for search ex: if you enter $StartDate 12/12 it will be 12/11  $TEndDate 12/12 will be 12/13
$StartDate =  (Read-Host -Prompt 'Enter the start date of the logs, Ex: 11/28/2019 or 11/27/2019 07:41 AM')
if($StartDate -eq ''){
   $StartDate = Get-Date 
   $TStartDate= Get-Date.AddDays(-1) -Format yyyyMMdd
}
else{
   $StartDate = Get-Date $StartDate 
   $TStartDate= Get-Date $StartDate.AddDays(-1) -Format yyyyMMdd

}
$EndDate = (Read-Host -Prompt 'Enter the   End  date of the logs,  Ex: 12/03/2019 or 11/28/2019 04:33 AM') 

if($EndDate -eq ''){
   $EndDate = Get-Date 
   $TEndDate= Get-Date.AddDays(1) -Format yyyyMMdd
}
else{
   $EndDate = Get-Date $EndDate 
   $TEndDate= Get-Date $EndDate.AddDays(1) -Format yyyyMMdd
}  

#set loop folder
$RMFolder=$RemotePath + "_" +$TStartDate   
write-host $RMFolder 

$fodersList = New-Object System.Collections.ArrayList
$fodersList= Get-ChildItem  -Directory -Filter "LotTracking*"

for ( $i = 0; $i -lt $fodersList.count; $i++)
    {
       write-host  $fodersList[$i].name
    }
      

write-host "Your StartDate is "  $StartDate
write-host "Your EndDate is "$EndDate
write-host "=========================================================="
$tempdate=Get-Date
write-host "Start to copy files" $tempdate 
$filecounter = 0 

for ( $i = 0; $i -lt $fodersList.count; $i++){ 

$TempPath=$RemotePath + $fodersList[$i].name

if($fodersList[$i].name -ne "LotTracking" -or $fodersList[$i].name.Substring(12,8) -lt $TStartDate -or $fodersList[$i].name.Substring(12,8)-ge $TEndDate)
{
  write-host $TStartDate
  write-host $TEndDate
  continue 
}


Foreach($file in (Get-ChildItem $TempPath)) {

    #If($StartDate.DateTime -le $file.LastWriteTime -and $EndDate.DateTime -ge  $file.LastWriteTime) 
     If($file.LastWriteTime -ge $StartDate.DateTime -and $file.LastWriteTime -le $EndDate.DateTime ) 
    {         
        if (!(Test-path (join-path $targetFolder $fodersList[$i].name )))
        {
             Copy-Item -Path  $file.fullname -Destination $targetFolder -Include *LotTracking*  
             $filecounter ++         
             write-host $file.Name " " $file.LastWriteTime           
        }
    }
}
}
$tempdate=Get-Date
write-host "Copy files compile!!!!" $tempdate  " Total files:"  $filecounter
Read-Host -Prompt "Press Enter to continue!!!"



