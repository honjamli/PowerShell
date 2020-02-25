
$RemotePath1 = "\\amknt132\tibco_logs\" 
$fodersList = New-Object System.Collections.ArrayList 

$fodersList = Get-ChildItem  $RemotePath1 -Include *LotTracking*

foreach ($a in $fodersList )
{
    write-host $a
}