function GetLogList($RemotePath) {  
$tamp =  New-Object System.Collections.Generic.List[System.Object]
$fodersList = New-Object System.Collections.ArrayList   
Foreach($file in (Get-ChildItem $RemotePath -Include *LotTracking* )) {   
            # write-host $file.fullname  
            $tamp=$file.fullname 
            [void]$fodersList.Add($tamp) 
    } 
  
  return $fodersList
}
 