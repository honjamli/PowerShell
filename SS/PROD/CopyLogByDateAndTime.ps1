#===================User Default=========================================
#put copy to your laptop location must create by yourself
$targetFolder = "C:\AAA\ProductionLogs\LotTracking\"  
#========================================================================  

#===================Function=============================================
#function for get RemotePath and fillter key worlds
Import-Module "C:\Power\PROD\GetLogList.ps1" 
#function for get Input Date and time 
Import-Module "C:\Power\PROD\GetInputDate.ps1" 
#========================================================================

$ListServerPath =  New-Object System.Collections.Generic.List[System.Object]
$RemotePath = "\\amknt131\tibco_logs\" 
$RemotePath1 = "\\amknt132\tibco_logs\" 

$ListServerPath=GetLogList($RemotePath)
$ListServerPath+=GetLogList($RemotePath1)

$return =GetInputDate
     
$StartDate=$return.StartDate
$TStartDate=$return.TStartDate
$EndDate=$return.EndDate
$TEndDate=$return.TEndDate

write-host "Your StartDate is "  $StartDate
write-host "Your EndDate is "$EndDate
write-host "=========================================================="
$tempdate=Get-Date
write-host "Start to copy files" $tempdate 
$filecounter = 0 
$passThru=0
for ( $i = 0; $i -lt $ListServerPath.count; $i++){  

if($ListServerPath[$i].Length-gt 33){ 
    if($ListServerPath[$i].Substring(34,8) -le $TStartDate -or $ListServerPath[$i].Substring(34,8)-ge $TEndDate){
    continue 
    }  
}  

Foreach($file in (Get-ChildItem $ListServerPath[$i])) {  

    #If($StartDate.DateTime -le $file.LastWriteTime -and $EndDate.DateTime -ge  $file.LastWriteTime) 
     If($file.LastWriteTime -ge $StartDate.DateTime -and $file.LastWriteTime -le $EndDate.DateTime ) 
    {       
  
        if (!(Test-path (join-path $targetFolder $file.fullname )))
        {
          $passThru= ( Copy-Item -Path  $file.fullname -Destination $targetFolder -Include *LotTracking* -passThru).count 
                     
        } 
          $filecounter += $passThru 
         if($passThru -gt 0){
             write-host $ListServerPath[$i]
             write-host $file.Name " " $file.LastWriteTime  
         }
    }
}
}
$tempdate=Get-Date
write-host "Copy files compile!!!!" $tempdate  " Total files:"  $filecounter
Read-Host -Prompt "Press Enter to continue!!!"
 