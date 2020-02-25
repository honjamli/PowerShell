#===================User Default=========================================
#put copy to your laptop location must create by yourself
$targetFolder = "C:\AAA\ProductionLogs\LotTracking\"  
#========================================================================  

#===================Function=============================================
#function for get RemotePath and fillter key worlds
#Import-Module "\\Amkfiler1.amk.st.com\amk5fab\ICT\MSG-AUTO\AMK SITE\Lot Tracking_ScannGo\Logs Analysis\PStool\GetLogList.ps1" 
Import-Module "C:\VSProbjet\powershell\PROD\PStool\GetLogList.ps1" 
#function for get Input Date and time 
#Import-Module "\\Amkfiler1.amk.st.com\amk5fab\ICT\MSG-AUTO\AMK SITE\Lot Tracking_ScannGo\Logs Analysis\PStool\GetInputDate.ps1" 
Import-Module "C:\VSProbjet\powershell\PROD\PStool\GetInputDate.ps1" 
#========================================================================
$ListServerPath =  New-Object System.Collections.ArrayList  
 
$RemotePath = "\\amksw91103\tibco_logs\" 
#$RemotePath1 = "\\amksw91104\tibco_logs\"  
#$RemotePath = "\\amknt131\tibco_logs\" 
$RemotePath1 = "\\amknt132\tibco_logs\"   
 
$ListServerPath.Addrange(@(Get-ChildItem  $RemotePath -Include *LotTracking*))
$ListServerPath.Addrange(@(Get-ChildItem  $RemotePath1 -Include *LotTracking*))

#show your copy paths
#foreach ($a in $ListServerPath ){ write-host $a}
  
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
 
#determine the folders' name include 2020 or not for skip copy file 
if($ListServerPath[$i] -like '*'+$TEndDate.Substring(0,4)+'*')
{ 
    #write-host $ListServerPath[$i].ToString().EndsWith($TStartDate) 
    if($ListServerPath[$i].ToString().EndsWith($TStartDate) -lt $TStartDate -or $ListServerPath[$i].ToString().EndsWith($TEndDate)-gt $TEndDate){
        continue
    }
} 

Foreach($file in (Get-ChildItem $ListServerPath[$i])) {    
    #If($StartDate.DateTime -le $file.LastWriteTime -and $EndDate.DateTime -ge  $file.LastWriteTime) 
     If($file.LastWriteTime -ge $StartDate.DateTime -and $file.LastWriteTime -le $EndDate.DateTime ) 
    {   
        if (!(Test-path (join-path $targetFolder $file.fullname ))) {
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
 