<#
Formatting Basics

Useful to check the appropriate .format.ps1xml Files
WARNING: DO NOT EDIT OR SAVE THEM - You'll break the formatting if you don't know what you're doing

#>

#Gets the Service BITS and displays it
Get-Service bits

#Gets the Parameter details on the type of object this Get-Service 'Name' is
#Example: TypeName   : System.ServiceProcess.ServiceController
Get-Service | Get-Member Name

#This will get the DotNetTypes.format.ps1xml file contents in the $PSHome Directory
#Then it will search for the string 'System.ServiceProcess.ServiceController' using Select-String
#Using the Parameter and argument -Context 0,30 will mean it displays the line that contains the string, as well as the following 30 lines
#Piping to more just allows us to stop and look at the output
Get-Content $PSHOME\DotNetTypes.format.ps1xml | Select-String System.ServiceProcess.ServiceController -Context 0, 30 | more

#Formats a Table of the .txt files found in C:\Temp\PoShTest\ and displays their FullName,Length,LastWriteTime
Get-ChildItem -File C:\Temp\PoShTest\*.txt | Format-Table FullName, Length, LastWriteTime

#Formats a Table of the .txt files found in C:\Temp\PoShTest\ and displays their FullName,Length,LastWriteTime
Get-ChildItem -File C:\Temp\PoShTest\*.txt | Format-Table FullName, Name,
@{Name = "Size"; Expression = { $_.Length } },
@{Name = "Age(Days"; Expression = { (Get-Date) - $_.LastWriteTime | Select-Object -ExpandProperty TotalDays } }

#When trying to Format a Group Object, you should always Sort it first, otherwise PowerShell won't know to sort them before grouping
Get-Service | Sort-Object Name | Format-Table -GroupBy Status -Property DisplayName, Status

#Gets all the files recursively in C:\Temp\PoShTest\, Groups them by Extensions (.exe, .zip, .txt)
#Then Selects the Properties Count, Name and TotalKB (Custom-made), measures the total Count and Size of the types of extensions found and adds them together
#Expands the Sum property and formats it to a Table
Get-ChildItem C:\Temp\PoShTest -File -Recurse | Group-Object Extension | Select-Object Count, Name,
@{Name = "TotalKB"; Expression = { $_.Group | Measure-Object Length -Sum | Select-Object -ExpandProperty Sum } } |
Format-Table -Group Name -Property Count, TotalKB
