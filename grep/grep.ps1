
Import-Module "E:\VScode\PowerShell\grep\grep01.ps1" 

$LocalPath = "E:\VScode\learnPython\SS\LotTracking_Manager-LotTracking_Manager-131-1.log.1"
$Filter ="*LotTracking*"

$key1="0066472546"
$key2="C001VP9"
$key3="6006E5F"
$key4="0066477921"
$key5=""
$key6=""  
$SearchString=$key1 

$tempdate=Get-Date
write-host "Start to search files" $tempdate 

Get-ChildItem -Path $LocalPath -File -Filter $Filter | Select-String -Pattern $key1,$key3  | Select Filename,LineNumber,line | Format-table -AutoSize | Out-File -Width 512 E:\VScode\PowerShell\grep\log.txt -Append

$tempdate=Get-Date
write-host "search files compile!!!!" $tempdate 
