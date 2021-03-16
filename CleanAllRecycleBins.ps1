#Cleans all Recycle Bins of ALL Users on the Local Host

#Get-ChildItem "C:\`$Recycle.bin\" will get all files that are present in all User Recycle Bins (it won't display what they are)
#That gets piped to Remove-Item and requires recurse and force to work
#If worried about what will be deleted, run the Get-ChildItem portion separately on it's own to verify
Get-ChildItem "C:\`$Recycle.bin\" -Force -Recurse | Remove-Item -Recurse -Force