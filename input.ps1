$arrayInput = @()

$StartDate =  (Read-Host -Prompt 'Enter the start date of the logs, Ex: 11/28/2019 or 11/27/2019 07:41 AM')
if($StartDate -eq ''){
   $StartDate = Get-Date 
}
else{
$StartDate = Get-Date $StartDate 
}
write-host   $StartDate

$EndDate = (Read-Host -Prompt 'Enter the   End  date of the logs,  Ex: 12/03/2019 or 11/28/2019 04:33 AM') 

if($EndDate -eq ''){
   $EndDate = Get-Date 
}
else{
   $EndDate = Get-Date $EndDate 
}
write-host   $EndDate

do {
$input = (Read-Host "Please enter the Array Value")
if ($input -ne '') {$arrayInput += $input}
}
#Loop will stop when user enter 'END' as input
until ($input -eq 'end')
 1
$arrayInput