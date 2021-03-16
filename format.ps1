<# Formatting Basics

PowerShell checks configuration file for instructions:
    Checks first the PowerShell Home Directory: '$PSHome\*******.format.ps1xml'
        in '*.format.ps1xml' files - Defines/describes the Default and alternate layouts for each particular type of object
            It tells PowerShell when it sees a type of object, create a table with the default properties and values found in the respective format file
        You can create custom format files as well (Useful when creating PowerShell Modules)
    Note: PowerShell might check the 'types.ps1xml' in the same folder for a defaul set of properties for a given object 

PowerShell Simple Default Rules:
    If < 5 Properties - Display a Table
    If >= 5 Properties - Display a List

    You can override the default rules with Format Cmdlets
#>