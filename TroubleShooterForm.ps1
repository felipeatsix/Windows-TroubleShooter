# Author: Felipe de Souza Santos / felipe-santos@outlook.com

$MyPath = Split-Path -Path $MyInvocation.MyCommand.Definition
$ElysiumPath = "$MyPath\Elysium_DLL_files"

[void][System.Reflection.Assembly]::LoadFrom("$ElysiumPath\Elysium.dll")
[void][System.Reflection.Assembly]::LoadFrom("$ElysiumPath\Microsoft.Expression.Drawing.dll")

[xml]$form = Get-Content "$MyPath\TroubleShooterXaml.xaml"

$Exclamation = [System.Windows.MessageBoxImage]::Exclamation
$Warning = [System.Windows.MessageBoxImage]::Warning
$Success = [System.Windows.MessageBoxImage]::Information
$OKButton = [System.Windows.MessageBoxButton]::OK


$UserMessage = "* user data has been successfully collected!"
$UserNotFoundMessage = "* could not be found in Active Directory!"
$BlankMessage = "Computer Name name field is blank!"
$UserBlankMessage = "User Name name field is blank!"
$ConnectionMessage = "* is not reachable!"
$SuccessMessage = "* data has been successfully collected!"
$FailedMessage = "Failed to get information from *, check if you have admin privileges in the destination computer."

$NR = (New-Object System.Xml.XmlNodeReader $Form)
$Win = [Windows.Markup.XamlReader]::Load($NR) 

$computer = $win.FindName("ComputerName")
$user = $win.FindName("Username")
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
$Image = $Win.FindName("image")
$Title = $Win.FindName("Title")
$Department = $Win.FindName("Department")
$DepartmentNumber = $Win.FindName("DepartmentNumber")
$LoginShell = $Win.FindName("LoginShell")
$LastLogon = $Win.FindName("LastLogon")
$PassLastSet = $Win.FindName("PassLastSet")
$LastBadPass = $Win.FindName("LastBadPass")
$LockedOut = $Win.FindName("LockedOut")
$LabelUserInfo = $Win.FindName("LabelUserInfo")
$LabelComputerSystemInfo = $Win.FindName("LabelComputerSystemInfo")
$RadioInfo = $Win.FindName("RadioInfo")
$RadioWarning = $Win.FindName("RadioWarning")
$RadioError = $Win.FindName("RadioError")
$LaptopIP = $Win.FindName("Laptop")
$DockIP = $Win.FindName("Dock")
