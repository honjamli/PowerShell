$T ="C:\AAA\1\W1"

$A="HELLO"

write-host $T
write-host $A

$temp=  -join ($T,$A)

write-host $temp

if (!(Test-Path $T)){
    New-Item -ItemType Directory -Path $T
     Write-Host "$T Folder Created Successfully"
}
