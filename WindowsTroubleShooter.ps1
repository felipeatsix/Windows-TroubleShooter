# Author: Felipe de Souza Santos / felipe-santos@outlook.com

Begin {

    Add-Type -AssemblyName PresentationFramework
    $LoadPath = Split-Path -Path $MyInvocation.MyCommand.Definition
    . "$LoadPath\TroubleShooterForm.ps1"
    . "$LoadPath\TroubleShooterFunctions.ps1"
    $Win.Icon = "$LoadPath\Images\Icon.ico"
    $Image.Source = "$LoadPath\Images\Image.png"
    $ArrSysEv = New-Object System.Collections.ArrayList
    $ArrEv = New-Object System.Collections.ArrayList
    $ArrProc = New-Object System.Collections.ArrayList
    $ArrNet = New-Object System.Collections.ArrayList    
}

Process {

    $SearchComputer.add_click({        

        Reset-ComputerData
        $ComputerName = $Computer.Text

        If ($ComputerName -ne "") {
        
            If (!(Test-Connection $ComputerName -Quiet -Count 1)) {

                $Message = $ConnectionMessage.Replace('*', $ComputerName)
                [System.Windows.MessageBox]::Show($Message,'Error',$OKButton,$Exclamation)            
            }

            Else {

                Try {

                    Get-SysTab $ComputerName

                    $SysEvents = Get-SysEvent $ComputerName
                    $ArrSysEv.AddRange($SysEvents)
                    $SeDG.ItemsSource = @($ArrSysEv)

                    $Events = Get-EventTab $ComputerName information,error,warning
                    $ArrEv.AddRange($Events)
                    $Edg.ItemsSource = @($ArrEv)

                    $Procs = Get-ProcTab $ComputerName
                    $ArrProc.AddRange($Procs)
                    $Pdg.ItemsSource = @($ArrProc)
                    
                    $Message = $SuccessMessage.Replace('*',$ComputerName)
                    [System.Windows.MessageBox]::Show($Message,'Success',$OKButton,$Success)
                    $LabelComputerSystemInfo.Content = "COMPUTER DATA: $ComputerName"                    
                }

                Catch {                     
                
                    $Message = $FailedMessage.Replace('*',$ComputerName)
                    [System.Windows.MessageBox]::Show($Message,'Failed',$OKButton,$Exclamation) 
                } 
            }
        }        
        
        Else { [System.Windows.MessageBox]::Show($BlankMessage,'Error',$OKButton,$Warning) }
    })

    $SearchUser.add_click({
        
        Reset-UserData
        $Username = $user.text                    
        
        If ($Username -ne "") {
        
            Try {
                
                Get-UserTab $Username
                $Message = $UserMessage.Replace("*", $Username)                
                [System.Windows.MessageBox]::Show($Message,'Success',$OKButton,$Success)                
                $LabelUserInfo.Content = "USER DATA: $Username"  
            }
            
            Catch {
                
                $Message = $UserNotFoundMessage.Replace('*',$Username)
                [System.Windows.MessageBox]::Show($Message,'Failed',$OKButton,$Exclamation) 
            }
       
        }

        Else { [System.Windows.MessageBox]::Show($UserBlankMessage,'Error',$OKButton,$Warning) }
    })

    $RadioInfo.add_click({ SortEntryType 'Information' })
    $RadioWarning.add_click({ SortEntryType 'Warning' })
    $RadioError.add_click({ SortEntryType 'Error' })
}

End { $Win.ShowDialog() }
