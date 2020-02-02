#Start IE and navigate to your download file/location
$ie = New-Object -Com internetExplorer.Application
$ie.Navigate("https://aboullaite.me/jsoup-html-parser-tutorial-examples/")

#------------------------------
#Wait for Download Dialog box to pop up
Sleep 5
while($ie.Busy){Sleep 1} 
#------------------------------

#Hit "S" on the keyboard to hit the "Save" button on the download box
$obj = new-object -com WScript.Shell
$obj.AppActivate('Internet Explorer')
$obj.SendKeys('s')

#Hit "Enter" to save the file
$obj.SendKeys('{Enter}')

#Closes IE Downloads window
$obj.SendKeys('{TAB}')
$obj.SendKeys('{TAB}')
$obj.SendKeys('{TAB}')
$obj.SendKeys('{Enter}')