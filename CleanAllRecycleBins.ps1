#Cleans all Recycle Bins of ALL Users on the Local Host

Get-ChildItem "C:\`$Recycle.bin\" -Force -Recurse | Remove-Item -Recurse -Force