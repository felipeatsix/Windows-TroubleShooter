$MyPath = Split-Path -Path $MyInvocation.MyCommand.Definition
$ElysiumPath = "$MyPath\Elysium_DLL_files"

[void][System.Reflection.Assembly]::LoadFrom("$ElysiumPath\Elysium.dll")
[void][System.Reflection.Assembly]::LoadFrom("$ElysiumPath\Microsoft.Expression.Drawing.dll")

[xml]$form = Get-Content "$MyPath\TroubleShooterForm.xaml"

$ArrSysEv = New-Object System.Collections.ArrayList
$ArrEv = New-Object System.Collections.ArrayList
$ArrProc = New-Object System.Collections.ArrayList

$Exclamation = [System.Windows.MessageBoxImage]::Exclamation
$Warning = [System.Windows.MessageBoxImage]::Warning
$Success = [System.Windows.MessageBoxImage]::Information
$OKButton = [System.Windows.MessageBoxButton]::OK

$BlankMessage = "* name field cannot be blank!"
$ConnectionMessage = "* is not reachable!"
$SuccessMessage = "* data has been successfully collected!"
$UserMessage = "User * could not be found!"
$FailedMessage = "Failed to get information from *, check if you have admin privileges in the destination computer."

$NR = (New-Object System.Xml.XmlNodeReader $Form)
$Win = [Windows.Markup.XamlReader]::Load($NR) 

$computer = $win.FindName("ComputerName")
$username = $win.FindName("Username")
$SearchComputer = $win.FindName("SearchComputer")
$Searchuser = $win.FindName("SearchUser")
$os = $win.FindName("OS")
$Inst = $win.FindName("InstallDate")
$edg = $win.FindName("EVdataGrid")
$sedg = $win.FindName("SysEvDataGrid")
$pdg = $win.FindName("ProcDataGrid")
$Lbupt = $win.FindName("BootTime")
$CurrentUser = $win.FindName("UserNameInfo")
$Model = $win.FindName("Model")
