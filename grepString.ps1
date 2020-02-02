# "2019 Nov 28 06:06:46:779"
$search =  (Read-Host -Prompt 'Enter your want to search ex: 12345 abcd')

dir -Recurse | Select-String -pattern $search.ToString()

write-host 