$location = -join((Get-Location),"\")   
$PropertyFilePath= Get-Item  $location*.property   
if ($PropertyFilePath -eq "") 
{
    write-host "You need to set property file in the folder"
}
$file = get-content $PropertyFilePath

$file | foreach {
  $items = $_.split("=")
  if ($items[0] -eq "targetFolder") {$targetFolder = $items[1]}
  if ($items[0] -eq "otherFolder"){$otherFolder = $items[1]}
  if ($items[0] -eq "testFolder"){$testFolder = $items[1]}
}
 
 
write-host $targetFolder $otherFolder  $testFolder
 