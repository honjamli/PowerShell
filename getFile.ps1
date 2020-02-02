$RemotePath = "\\amknt132\tibco_logs\LotTracking_20191128\"
$LocalPath = "C:\AAA\"
$targetFolder = "C:\AAA\1\"  
 

 $Sdate =Get-Date '11/28/2019 04:33 AM'
 $Edate =Get-Date '11/28/2019 04:44 AM'

Foreach($file in (Get-ChildItem $RemotePath)) {
    If($file.LastWriteTime -ge $Sdate.DateTime -and $file.LastWriteTime -le $Edate.DateTime ) 
    { 
        #Test to see if the file already exists in the destination. If not => Move/Copy/Action you want :D
        if (!(Test-path (join-path $targetFolder $file.name)))
        {
           Copy-Item -Path $file.fullname -Destination $targetFolder
        }
    }
}