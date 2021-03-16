<#
Custom Properties

	• Custom Property Fundamentals:
		○ Use a Special Hashtable
			§ Hashtables are Key-Value Pairs
		○ Required Keys for a Custom Property Hashtable:
			§ Name
			§ Express
Use the automatic variable $_ to reference the current object in the pipeline

Basic Outline of Custom Property Hashtable
@{Name = 'something' ; Expression = { <your code> }}

#>

#Gets the ID, Name, WS, StarTime,and Runtime (Custom-made) properties of the Process 'smartscreen'
#Runtime property is the total time it has been running since the process has been Started
Get-Process -Name smartscreen | Select ID,Name,WS,StartTime,@{Name='Runtime';Expression={(Get-Date) - $_.StartTime}}

#Gets the ID, Name, WS, StarTime,and Runtime (Custom-made) properties of the Top 10 Processes by CPU Utilization in Descending order
Get-Process | Sort-Object CPU -Descending | Select -First 10 -Property ID,Name,WS,StartTime,@{Name='Runtime';Expression={(Get-Date) - $_.StartTime}}

#Gets all the Properties for the Service object names 'BITS'
Get-Service -Name BITS -ComputerName $env:COMPUTERNAME | Select-Object *

<#
Get all Services on Local Host and selecting the DisplayName, Status, ComputerName (Custom-made) Properties and out them to Grid View

    Using a Custom-made Property called 'ComputerName' when there is already a MachineName Property (the .NET Object wants to use MachineName) 
    might seem unnecessary, but there's a good value: Many functions/cmdlets/objects in PowerShell have a 'ComputerName' Property
    Creating this will enable you to pipe your results easily into those other places in your pipeline/scripts that can accept a 'ComputerName' as input
#>
Get-Service -ComputerName $env:COMPUTERNAME | Select-Object DisplayName,Status,@{Name="ComputerName";Expression={$_.MachineName}} | Out-GridView -Title "$($env:COMPUTERNAME) Services"


<#
Get all Files Rercusively in a Directory, selecting the Name and SizeKB (Custom-made) Properties

    Using the Custom-made Property called 'SizeKB', we are able to check the Length, or size of the files, dividing the found file's length by 1KB,
    then using the [math] class operator: we invoke the 'Round' method and format it to the nearest 2 decimal places, 
    Modified Custom-made property gives us the date and time the file found was last modified, the ModifiedAge Custom-made property gives us
    the duration that has elapsed since the last time the file was modifed, the Path Custom-made variable gives us a shorter property name for the full path of the
    files found, and the 'ComputerName' custom-made property is useful so we can identify where the file resides if this was ran against the network
    but also so it can easily be piped into later in the pipeline
#>

Get-ChildItem -Path C:\Temp\PoShTest -File -Recurse |
 Select-Object Name,@{Name="SizeKB";Expression={[math]::Round($_.Length/1KB,2)}},
 @{Name="Modified";Expression={$_.LastWriteTime}},
 @{Name="ModifiedAge";Expression={(Get-Date) - $_.LastWriteTime}},
 @{Name="Path";Expression={$_.FullName}},
 @{Name="ComputerName";Expression={$env:COMPUTERNAME}}