$tempdate=Get-Date
write-host "Start to search files" $tempdate 

Get-ChildItem -Path C:\AAA\ProductionLogs\LotTracking\LotTracking_20200207\ -File -Filter  "*LotTracking*" |Select-String "W0068VEV01"

$tempdate=Get-Date
write-host "search files compile!!!!" $tempdate  