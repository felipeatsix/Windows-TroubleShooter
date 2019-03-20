Function Reset-Data {
    
    $Pdg.ItemsSource = $Null
    $Pdg.items.Refresh()

    $Edg.ItemsSource = $Null
    $Edg.Items.Refresh()

    $SeDG.ItemsSource = $Null
    $SeDG.Items.Refresh()
    
    $os.Content = ""
    $Inst.Content = ""
    $Lbupt.Content = ""
    $CurrentUser.Content = ""
    $Model.Content = ""
}

Function Get-SysTab($ComputerName) {    
    
    $Sys = Get-CimInstance win32_operatingsystem -CN $ComputerName | select-object Caption, installdate, LastBootUpTime
    $Csys = gwmi win32_computersystem -CN $ComputerName -ErrorAction SilentlyContinue| select *
    
    $Os.content = $Sys.caption
    $Inst.content = $Sys.installdate
    $Lbupt.content = $Sys.LastBootUpTime
    $CurrentUser.content = $Csys.UserName
    $Model.content = $Csys.Model    
}

Function Get-EventTab ($ComputerName) {
    
    $Ev = get-eventlog application -CN $computerName -newest 100 | 
    select TimeGenerated,EntryType,Source,InstanceID | Sort-Object -property Time         
    Return $Ev
}

Function Get-SysEvent ($ComputerName) {
    
    $SysEv = Get-EventLog system -CN $ComputerName -Newest 100 | 
    select TimeGenerated,EntryType,Source,InstanceId | Sort-Object -Property Time    
    Return $SysEv
}

Function Get-ProcTab ($ComputerName) {    
        
    $Proc = Get-Process -CN $ComputerName | Sort-Object ws -Descending     
    Return $Proc | Group-Object Name | select count,name
}
