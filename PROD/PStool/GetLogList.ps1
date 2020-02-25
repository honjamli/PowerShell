function GetLogList($RemotePath) {  
$temp =  New-Object System.Collections.Generic.List[System.Object]
$fodersList = New-Object System.Collections.ArrayList   
Foreach($file in (Get-ChildItem $RemotePath -Include *LotTracking* )) {   
            write-host $file.fullname  
            $temp=$file.fullname 
            [void]$fodersList.Add($temp) 
    } 
  
  return [System.Collections.ArrayList]$fodersList
}
 