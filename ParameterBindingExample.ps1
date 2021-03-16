#Parameter Binding Example: ByPropertyName

#Gets the status of the WinRM Service on Target Host 'RYZEN' using already made Cmdlets and PropertyName based parameter binding
Get-Service -Name WinRM -ComputerName 'RYZEN'


#Gets the status of the WinRM Service on Target Host 'RYZEN' using Custom made PSCustomObjects and piped to the Get-Service cmdlet
#PSCustomObjects below are a Key-Value Pair
[PSCustomObject]@{Name='winrm';ComputerName='RYZEN'} | Get-Service