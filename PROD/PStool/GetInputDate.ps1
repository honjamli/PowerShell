
function GetInputDate($RemotePath){
[hashtable]$result = @{} 

#if you don't input Start and End Date and then auto point Today
#cause nightshift logs acorss 2days and I define $TStartDate -1 and $TEndDate +1 for search ex: if you enter $StartDate 12/12 it will be 12/11  $TEndDate 12/12 will be 12/13
$StartDate =  (Read-Host -Prompt 'Enter the start date of the logs, Ex: 01/06/2020 or 11/27/2020 07:41 AM')

if($StartDate -eq ''){
   $StartDate = Get-Date  
   $TStartDate= Get-Date (Get-Date).AddDays(-1) -format yyyyMMdd 
}
else{
   $StartDate = Get-Date $StartDate 
   $TStartDate= Get-Date $StartDate.AddDays(-1) -Format yyyyMMdd

}
$EndDate = (Read-Host -Prompt 'Enter the   End  date of the logs,  Ex: 12/03/2019 or 11/28/2019 04:33 AM') 

if($EndDate -eq ''){
   $EndDate = Get-Date                       
   $TEndDate= Get-Date (Get-Date).AddDays(1) -format yyyyMMdd
}
else{
   $EndDate = Get-Date $EndDate 
   $TEndDate= Get-Date $EndDate.AddDays(1) -Format yyyyMMdd
} 
$result.StartDate=$StartDate 
$result.TStartDate=$TStartDate 
$result.EndDate=$EndDate 
$result.TEndDate=$TEndDate  
 
return $result
}