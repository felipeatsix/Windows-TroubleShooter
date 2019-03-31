# Author: Felipe de Souza Santos / felipe-santos@outlook.com

Function Reset-ComputerData {
    
    $Pdg.ItemsSource = $Null
    $Pdg.items.Refresh()
    
    $Edg.ItemsSource = $Null
    $Edg.Items.Refresh()
    
    $SeDG.ItemsSource = $Null
    $SeDG.Items.Refresh()

    $LabelComputerSystemInfo.content = "COMPUTER DATA:"
    $os.Content = ""
    $Inst.Content = ""
    $Lbupt.Content = ""
    $CurrentUser.Content = ""
    $Model.Content = ""
}
Function Reset-UserData {

    $LabelUserInfo.Content = "USER DATA:"
    $Title.Content = ""
    $Department.Content = "" 
    $DepartmentNumber.Content = ""
    $LoginShell.Content = ""
    $LastLogon.Content = ""
    $PassLastSet.Content = ""
    $LastBadPass.Content = ""
    $LockedOut.Content = ""    
}
Function Get-SysTab($ComputerName) {    
    
    $Sys = Get-CimInstance win32_operatingsystem -CN $ComputerName | select-object Caption, installdate, LastBootUpTime
    $Csys = Get-WmiObject win32_computersystem -CN $ComputerName -ErrorAction SilentlyContinue | Select-Object username,model
    $NetConf = Get-WmiObject win32_networkadapterconfiguration -CN $ComputerName

    $ArrNet.AddRange($NetConf)
    $Dock = $ArrNet | where {$_.Description -like '*Realtek USB*'} | select *
    $Laptop = $ArrNet | where {$_.Description -like '*Ethernet*'} | select *
    
    $Os.content = $Sys.caption
    $Inst.content = $Sys.installdate
    $Lbupt.content = $Sys.LastBootUpTime
    $CurrentUser.content = $Csys.UserName
    $Model.content = $Csys.Model
    $DockIP.content = "$($Dock.MacAddress) / $($Dock.IPAddress)"
    $LaptopIP.content = "$($Laptop.MacAddress) / $($Laptop.IPAddress)"
}
Function Get-UserTab ($Username) {

    $Filter = @(        
        'Title' 
        'Department'
        'DepartmentNumber' 
        'LoginShell'     
        'LastLogonDate'
        'PasswordLastSet'
        'LastBadPasswordAttempt'
        'LockedOut'
    )

    If ($UserData = Get-ADUser -Identity $Username -Properties * | Select-Object $Filter) {
            
        $Title.Content = $UserData.Title
        $Department.Content = $UserData.Department
        $DepartmentNumber.Content = $($UserData.DepartmentNumber)
        $LoginShell.Content = $UserData.LoginShell
        $LastLogon.Content = $UserData.LastLogonDate
        $PassLastSet.Content = $UserData.PasswordLastSet
        $LastBadPass.Content = $UserData.LastBadPasswordAttempt
        $LockedOut.Content = $UserData.LockedOut         
    }
}
Function Get-EventTab ($ComputerName,$EntryType) {
        
    $Ev = get-eventlog application -ComputerName $computerName -EntryType $EntryType -Newest 30 | 
    Select-Object TimeGenerated,EntryType,Source,InstanceID,Message | Sort-Object -property Time         
    Return $Ev
}
Function SortEntryType ($Filter){

    $ArrEv.Clear()
    $ComputerName = $Computer.Text
    $Events = Get-EventTab $ComputerName $Filter                                                      
    $ArrEv.AddRange($Events)
    $Edg.ItemsSource = @($ArrEv)
    $Edg.Items.Refresh()
}
Function Get-SysEvent ($ComputerName) {
    
    $SysEv = Get-EventLog system -CN $ComputerName -Newest 100 -EntryType Error,Warning | 
    Select-Object TimeGenerated,EntryType,Source,InstanceId,Message | Sort-Object -Property Time    
    Return $SysEv
}

Function Get-ProcTab ($ComputerName) {    
        
    $Proc = Get-Process -CN $ComputerName | Sort-Object ws -Descending     
    Return $Proc | Group-Object Name | Select-Object count,name
}
