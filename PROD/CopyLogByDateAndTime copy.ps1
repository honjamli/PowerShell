#===================User Default============================================================================================== 
$location = -join((Get-Location),"\")   
$PropertyFilePath= Get-Item  $location*.property    
$prop = get-content $PropertyFilePath 

$prop | foreach {
  $items = $_.split("=")
  if ($items[0] -eq "targetFolder") {$targetFolder = $items[1].trim() -replace '"',''}
  if ($items[0] -eq "otherFolder"){$otherFolder = $items[1].trim() -replace '"',''}
  if ($items[0] -eq "testFolder"){$testFolder = $items[1].trim() -replace '"',''}
}
 write-host "Here are your PropertyPath !!!"
 write-host $targetFolder
 write-host $otherFolder
 write-host $testFolder
 write-host "=================================" 
#=============================================================================================================================  

#===================Function================================================================================================== 
#Import-Module "\\Amkfiler1.amk.st.com\amk5fab\ICT\MSG-AUTO\AMK SITE\Lot Tracking_ScannGo\Logs Analysis\PStool\GetInputDate.ps1"  
Import-Module "C:\VSProbjet\powershell\PROD\PStool\GetInputDate.ps1" 
#=============================================================================================================================

#===================PROD-RemotePath===========================================================================================
#for LotTracking
$ListServerPath = New-Object System.Collections.ArrayList
##for other log  
$ListfilesPath = New-Object System.Collections.ArrayList

##Prod-LotTracking Logs  *LotTracking* ##
$RemotePath1 = "\\amknt131\tibco_logs\" 
$RemotePath2 = "\\amknt132\tibco_logs\"  
$RemotePath3 = "\\amksw91103\tibco_logs\" 
$RemotePath4 = "\\amksw91104\tibco_logs\"  
##Prod-F13_F13LOADER_ScanNGoGUI_logs  *F13* *ScanNGoGUI*
$RemotePath5 = "\\amksw91103\logs\"
$RemotePath6 = "\\amksw91104\logs\"  
$RemotePath9 = "\\amknt131\logs\"
$RemotePath10 = "\\amknt132\logs\"
##TestServer-F13_F13LOADER_ScanNGoGUI_LotTracking_logs  *F13* *ScanNGoGUI* *LotTracking*
$RemotePath7 = "\\amknt162\logs" 
$RemotePath8 = "\\amknt163\logs" 

$ListServerPath.Addrange(@(Get-ChildItem  $RemotePath1 -Include *LotTracking*))
$ListServerPath.Addrange(@(Get-ChildItem  $RemotePath2 -Include *LotTracking*))
$ListServerPath.Addrange(@(Get-ChildItem  $RemotePath3 -Include *LotTracking*))
$ListServerPath.Addrange(@(Get-ChildItem  $RemotePath4 -Include *LotTracking*)) 

$Flag = (Read-Host -Prompt 'Do you want copy F13_F13LOADER_ScanNGoGUI_logs ? If you want enter Y')
write-host 'Your answer is: '  $Flag 
#only 2020 logs
$copydate = Get-Date 01/01/2020
if ($Flag -eq 'Y') {
    $ListfilesPath.Addrange(@(Get-ChildItem  $RemotePath5 -Include *ScanNGo*, *F13* ))
    $ListfilesPath.Addrange(@(Get-ChildItem  $RemotePath6 -Include *ScanNGo*, *F13* )) 
    $ListfilesPath.Addrange(@(Get-ChildItem  $RemotePath9 -Include *ScanNGo*, *F13* ))  
    $ListfilesPath.Addrange(@(Get-ChildItem  $RemotePath10 -Include *ScanNGo*, *F13* ))  	
	
    Foreach ($file in (Get-ChildItem $ListfilesPath)) {  
		#write-host  $file.Directory 
		$Dir=$file.Directory -replace '\\\\',''
		#write-host  $Dir
		$Dir= -join ($otherFolder,$Dir)
		#write-host  $Dir
        if (!(Test-Path $Dir)){
            New-Item -ItemType Directory -Path $Dir
            Write-Host "$Dir Folder Created Successfully"
        }		
        If ($file.LastWriteTime -ge $copydate.DateTime) {
            $passThru = ( Copy-Item -Path  $file.fullname -Destination $Dir -passThru).count 
            if ($passThru -gt 0) { 
                write-host $file " " $file.LastWriteTime  
            }
        }
    }
    write-host  "F13_F13LOADER_ScanNGoGUI_logs copy finished!!!"
	write-host "=========================================================================================="
}
#===================PROD-RemotePath===========================================================================================
#===================TEST-RemotePath===========================================================================================
$TestFlag = (Read-Host -Prompt 'Do you want copy TestServer-F13_F13LOADER_ScanNGoGUI_LotTracking.logs ? If you want enter Y')
##for testServer log  
$ListTestPath = New-Object System.Collections.ArrayList 
write-host 'Your answer is: '  $TestFlag 
#only 2020 logs
$copydate = Get-Date 01/01/2020
if ($TestFlag -eq 'Y') {
    $ListTestPath.Addrange(@(Get-ChildItem  $RemotePath7 -Include *ScanNGo*, *F13*,*LotTracking* ))    
    $ListTestPath.Addrange(@(Get-ChildItem  $RemotePath8 -Include *ScanNGo*, *F13*,*LotTracking* )) 
    Foreach ($file in (Get-ChildItem $ListTestPath)) { 
		$Dir=$file.Directory -replace '\\\\',''  
		$Dir= -join ($testFolder,$Dir)
        if (!(Test-Path $Dir)){
            New-Item -ItemType Directory -Path $Dir
            Write-Host "$Dir Folder Created Successfully"
        }		
        If ($file.LastWriteTime -ge $copydate.DateTime) {
            $passThru = ( Copy-Item -Path  $file.fullname -Destination $Dir -passThru).count 
            if ($passThru -gt 0) { 
                write-host $file " " $file.LastWriteTime  
            }
        }
    }
    write-host  "TestServer-F13_F13LOADER_ScanNGoGUI_LotTracking_logs copy finished!!!"
	write-host "=========================================================================================="
}
#===================TEST-RemotePath===========================================================================================
#show your copy paths
#foreach ($a in $ListServerPath ){ write-host $a}
  
$return = GetInputDate
     
$StartDate = $return.StartDate
$TStartDate = $return.TStartDate
$EndDate = $return.EndDate
$TEndDate = $return.TEndDate

write-host "Your StartDate is "  $StartDate
write-host "Your EndDate is "$EndDate
write-host "=========================================================================================="
$tempdate = Get-Date
write-host "Start to copy files" $tempdate 
$filecounter = 0 
$passThru = 0
for ( $i = 0; $i -lt $ListServerPath.count; $i++) {
	
    #determine the folders' name include 2020 or not for skip copy file 
    if ($ListServerPath[$i] -like '*' + $TEndDate.Substring(0, 4) + '*') {  
         $TmepPath=$ListServerPath[$i].Name
         $tempDate=$TmepPath.Substring($TmepPath.LastIndexOf("_")+1,8)
        if ($tempDate -lt $TStartDate -or $tempDate -gt $TEndDate) {
            continue
        }
    } 
	
    Foreach ($file in (Get-ChildItem $ListServerPath[$i])) {    
        #write-host $ListServerPath[$i] " " $file.Name " " $file.LastWriteTime 
        If ($file.LastWriteTime -ge $StartDate.DateTime -and $file.LastWriteTime -le $EndDate.DateTime ) {  
            $localpath=""
            if([String]::IsNullOrEmpty($TmepPath)){  
                  $localpath=-join($targetFolder,"LotTracking\")
            }
            else{
                $localpath= -join($targetFolder,$TmepPath) 
            }

            if (!(Test-Path $localpath)){
                New-Item -ItemType Directory -Path $localpath
                 Write-Host "$localpath Folder Created Successfully"
            } 

            if (!(Test-path (join-path $localpath $file.fullname ))) {
                $passThru = ( Copy-Item -Path  $file.fullname -Destination $localpath -Include *LotTracking* -passThru).count 
            } 
            $filecounter += $passThru 
            if ($passThru -gt 0) {
				#write-host $t 
			    #write-host $tempDate  " "   $targetFolder 
                write-host $ListServerPath[$i] " " $file " " $file.LastWriteTime 
                #write-host $file.Name " " $file.LastWriteTime  
				
            }
        }
    }
}
$tempdate = Get-Date
write-host "Copy files compile!!!!" $tempdate  " Total files:"  $filecounter
Read-Host -Prompt "Press Enter to continue!!!"
 