
$RemotePath = "\\amknt132\tibco_logs\LotTracking_20191128\"
$LocalPath = "C:\AAA\"
#Set-Variable RemotePath -option Constant -value "\\amknt132\tibco_logs\LotTracking_20191128\"
#Set-Variable LocalPath  -option Constant -value "C:\AAA\"
#const RemotePath = "\\amknt132\tibco_logs\LotTracking_20191128\"
#const LocalPath = "C:\AAA\"  

$StartDate = Get-Date (Read-Host -Prompt 'Enter the start date of the logs, Ex: 11/27/2019 or 11/28/2019 08:36:00')
$EndDate = Get-Date (Read-Host -Prompt 'Enter the   End  date of the logs,  Ex: 12/03/2019 or 12/03/2019 09:00:00') 

   
 $ts = New-TimeSpan -Start $StartDate -End $EndDate
 $ts.Days
 

$date = (Get-Date).AddDays(-1).Date
Get-ChildItem –Path $RemotePath  –File   
Where-Object –Filter { $_.LastWriteTime –lt $date } 

write-host $date

#LastAccessTime
$StartTime=get-date     
write-host "Start-CopyFile: "    $StartTime   

#call  getFile
#GetBydate $StartDate $EndDate

$EndTime=get-date
write-host "End-CopyFile:   "    $EndTime   

 Foreach($file in (Get-ChildItem $RemotePath)){
 # write-host $file.FullName
 # write-host $file.LastWriteTime 
 
  if($StartDate -le $file.LastWriteTime -or $EndDate -ge $file.LastWriteTime){
   Copy-Item -Path $file.fullname -Destination $LocalPath
  }
  else
  {
  write-host $StartDate
    write-host  "not copying   "    $file.LastWriteTime 
  }

 }


#parm two days
function GetBydate($StartDate, $EndDate){  

  #Checking date and then copying file from RemotePath to LocalPath
    Foreach($file in (Get-ChildItem $RemotePath)){

      write-host $file.LastWriteTime
      write-host $StartDate
      write-host $EndDate
    
      if($StartDate -eq ""){
         $StartDate =$EndDate
      }

      if($EndDate -eq ""){
         $EndDate = "12/31/2099 00:00:00"
      } 


      if($StartDate -le $file.LastWriteTime -and $EndDate -gt $file.LastWriteTime){ 
        #Copy-Item -Path $file.fullname -Destination $LocalPath -recurse -Force
        #Move-Item -Path $file.fullname -Destination $LocalPath 

        Copy-Item -Path $file.fullname -Destination $LocalPath

      }
      else{
	    "not copying   " +  $file.LastWriteTime
      }

   }  

} 


#-gt greater than  
#-ge greater than or equal 
#-lt less than 
#-le less than or equal   