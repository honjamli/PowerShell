
$RemotePath = "\\amknt132\tibco_logs\LotTracking_20191128\"
$LocalPath = "C:\AAA\"
#Set-Variable RemotePath -option Constant -value "\\amknt132\tibco_logs\LotTracking_20191128\"
#Set-Variable LocalPath  -option Constant -value "C:\AAA\"
#const RemotePath = "\\amknt132\tibco_logs\LotTracking_20191128\"
#const LocalPath = "C:\AAA\" 


$StartDate = Get-Date (Read-Host -Prompt 'Enter the start date of the logs, Ex: 11/28/2019 or 11/28/2019 09:00:00')
$EndDate = Get-Date (Read-Host -Prompt 'Enter th    e   End  date of the logs,  Ex: 12/03/2019 or 12/03/2019 09:00:00')
 
Write-Host $StacrtDate
Write-Host $EndDate

#$Max_days = Read-Host -Prompt 'Input you want copy days from today ex: Today 0 ,Yesturday -1 ,before 2 days -2'
#$SearchTime = Read-Host -Prompt 'Input you want copy times   ex: 02:11:00 , 20:46:06 '
$Curr_date = get-date  
Write-Host "Your search days '$Max_days'" 
$StartTime=get-date

write-host $Curr_date
write-host "Start-CopyFile" + $StartTime  

$min = Get-Date '12:00'
$max = Get-Date '14:36'

$now = Get-Date


GetBydate  $min $max 


if ($min.TimeOfDay -le $now.TimeOfDay -and $max.TimeOfDay -ge $now.TimeOfDay) {
   write-host "HI THERE"
}


#Checking date and then copying file from RemotePath to LocalPath
Foreach($file in (Get-ChildItem $RemotePath))
{
    if($file.LastWriteTime -gt ($Curr_date).adddays($Max_days))
    { 
        Copy-Item -Path $file.fullname -Destination $LocalPath -recurse -Force
        #Move-Item -Path $file.fullname -Destination $LocalPath
		 
    }
    ELSE
    {
	"not copying   " +  $file.LastWriteTime
    }

} 

$EndTime=get-date
write-host "End-CopyFile"    $EndTime  
write-host "Use:"     $EndTime - $StarTime
 
 

#parm two days
function GetBydate($StartDate, $EndDate) { 

  #Checking date and then copying file from RemotePath to LocalPath
Foreach($file in (Get-ChildItem $RemotePath))
{
    if($StartDate -ge $file.LastWriteTime -le $EndDate )
    { 
        Copy-Item -Path $file.fullname -Destination $LocalPath -recurse -Force
        #Move-Item -Path $file.fullname -Destination $LocalPath
		 
    }
    ELSE
    {
	"not copying   " +  $file.LastWriteTime
    }

} 



}  