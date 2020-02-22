
$LocalPath = "C:\AAA\ProductionLogs\LotTracking\LotTracking_20200207\"
$Filter ="*LotTracking*"
$SearchString="W0068VEV01"  

$tempdate=Get-Date
write-host "Start to search files" $tempdate 

Get-ChildItem -Path $LocalPath -File -Filter $Filter | Select-String $SearchString

$tempdate=Get-Date
write-host "search files compile!!!!" $tempdate 
