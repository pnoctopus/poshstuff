#Generate Log files of Application Event Log Warnings/Errors Grouped by Source Type of the Warnings/Errors

Get-EventLog -LogName Application -EntryType Error,Warning | Group-Object Source |
 ForEach { $file = Join-Path -Path C:\Temp\PoShTest -ChildPath "$($_.Name).txt"
 "$($_.Count) entries" | Out-File -FilePath $file
 $_.Group | ForEach {
    $_ | Select-Object TimeGenerated,EntryType | Out-File -FilePath $file -Append
    $_ | Select-Object -ExpandProperty Message | Out-File -FilePath $file -Append
    }
Get-Item $file
}