function Get-TVIncomingLog_byDate{
    <#
    .SYNOPSIS
        Parses the connections_incoming.txt file and returns data before, after, or between a specific date
    
    .PARAMETER File
        Location to the connections_incoming.txt file
    
    .PARAMETER BeforeDate
        Returns data before the specified date
    
    .PARAMETER AfterDate
        Returns data after the specified date
    
    .EXAMPLE
        Get-TVIncomingLog_byDate -file "C:\Program Files (x86)\TeamViewer\connections_incoming.txt" -before "12/25/2020"

        Returns data before December 25, 2020
    
    .EXAMPLE
        Get-TVIncomingLog_byDate -file "C:\Program Files (x86)\TeamViewer\connections_incoming.txt" -after "12/25/2020"

        Returns data after December 25, 2020

    .EXAMPLE
        Get-TVIncomingLog_byDate -file "C:\Program Files (x86)\TeamViewer\connections_incoming.txt" -before "3/1/2021" -after "12/25/2020"

        Returns data after March 1, 2021 before December 25, 2020
    #>

    [CmdletBinding()]
    param(
        $File,
        $BeforeDate,
        $AfterDate
    )
    $logs = get-content $file

    $obj = @()
    $logs = $logs -replace (' ','_')
    $obj = foreach($log in $logs){
        $dur = ''
        $log = $log -split "\s+"
        $log = $log -replace ('_',' ')
        try{
            $log[2]= [datetime]::ParseExact($log[2],'dd-MM-yyyy HH:mm:ss', $null)
        } catch{ }
        try{
            $log[3]= [datetime]::ParseExact($log[3],'dd-MM-yyyy HH:mm:ss', $null) 
        } catch { }
        $dur = New-TimeSpan -start $log[2] -end $log[3] -ErrorAction SilentlyContinue
        [PSCustomObject]@{
            IncomingID = $log[0]
            DisplayName = $log[1]
            StartDate = $log[2]
            EndDate = $log[3]
            Duration = [string]$dur.ToString("dd'd.'hh'h:'mm'm:'ss's'")
            LoggedOnUser = $log[4]
            ConnectionType = $log[5]
            ConnectionID = $log[6]
        }
    }

    if($afterDate -and $beforeDate){
        $obj |where-object{$_.startdate -gt $afterDate -and $_.startdate -lt $beforeDate}
    }
    elseif($afterDate){
        $obj |where-object{$_.startdate -gt $afterDate}
    }
    elseif($beforeDate){
        $obj |where-object{$_.startdate -lt $beforeDate}
    }
}

function Get-TVIncomingLog_Top10Duration{
<#
.SYNOPSIS
    Parses the connections_incoming.txt file and returns the duration for the top 10 longest or shortest incoming connections

.PARAMETER File
    Location to the connections_incoming.txt file

.PARAMETER shortest
    Used select the shortest connections

.PARAMETER longest
    Used select the longest connections

.EXAMPLE
    Get-TVIncomingLog_Top10Duration -file "C:\Program Files (x86)\TeamViewer\connections_incoming.txt" 

    Returns the duration for all incoming connections

.EXAMPLE
    Get-TVIncomingLog_Top10Duration -file "C:\Program Files (x86)\TeamViewer\connections_incoming.txt" -shortest

    Returns the top 10 shortest durations for all incoming connections

.EXAMPLE
    Get-TVIncomingLog_Top10Duration -file "C:\Program Files (x86)\TeamViewer\connections_incoming.txt" -longest

    Returns the top 10 longest durations for all incoming connections
#>
    [CmdletBinding()]
    param(
        $File,
        [switch]$shortest,
        [switch]$longest
    )
    $logs = get-content $file

    $obj = @()
    $logs = $logs -replace (' ','_')
    $obj = foreach($log in $logs){
        $dur = ''
        $log = $log -split "\s+"
        $log = $log -replace ('_',' ')
        try{
            $log[2]= [datetime]::ParseExact($log[2],'dd-MM-yyyy HH:mm:ss', $null)
        } catch{ }
        try{
            $log[3]= [datetime]::ParseExact($log[3],'dd-MM-yyyy HH:mm:ss', $null) 
        } catch { }
        $dur = New-TimeSpan -start $log[2] -end $log[3] -ErrorAction SilentlyContinue
        [PSCustomObject]@{
            IncomingID = $log[0]
            DisplayName = $log[1]
            StartDate = $log[2]
            EndDate = $log[3]
            Duration = [string]$dur.ToString("dd'd.'hh'h:'mm'm:'ss's'")
            LoggedOnUser = $log[4]
            ConnectionType = $log[5]
            ConnectionID = $log[6]
        }
    }
    if($shortest){
        $obj | Sort-Object Duration -Top 10 | Format-Table
    }
    if($longest){
        $obj | Sort-Object Duration -Bottom 10 | Format-Table
    }
}

function Get-TVIncomingLog_Unique{
<#
.SYNOPSIS
    Parses the connections_incoming.txt and returns the unique incoming IDs, display names, or logged on users

.PARAMETER File
    Location to the connections_incoming.txt file

.PARAMETER IncomingID
    Used to select the returning of unique incoming IDs

.PARAMETER DisplayName
    Used to select the returning of unique display names

.PARAMETER LoggedOnUser
    Used to select the returning of unique logged on users

.EXAMPLE
    Get-TVIncomigLog_Unique -file "C:\Program Files (x86)\TeamViewer\connections_incoming.txt" -incomingid

    Returns the entries containing unique incoming IDs

.EXAMPLE
    Get-TVIncomigLog_Unique -file "C:\Program Files (x86)\TeamViewer\connections_incoming.txt" -displayname

    Returns the entries containing unique display names

.EXAMPLE
    Get-TVIncomigLog_Unique -file "C:\Program Files (x86)\TeamViewer\connections_incoming.txt" -loggedonuser

    Returns the entries containing unique logged on user

#>
    [CmdletBinding()]
    param(
        $File,
        [switch]$IncomingID,
        [switch]$DisplayName,
        [switch]$LoggedOnUser

    )
    $logs = get-content $file

    $obj = @()
    $logs = $logs -replace (' ','_')
    $obj = foreach($log in $logs){
        $dur = ''
        $log = $log -split "\s+"
        $log = $log -replace ('_',' ')
        try{
            $log[2]= [datetime]::ParseExact($log[2],'dd-MM-yyyy HH:mm:ss', $null)
        } catch{ }
        try{
            $log[3]= [datetime]::ParseExact($log[3],'dd-MM-yyyy HH:mm:ss', $null) 
        } catch { }
        $dur = New-TimeSpan -start $log[2] -end $log[3] -ErrorAction SilentlyContinue
        [PSCustomObject]@{
            IncomingID = $log[0]
            DisplayName = $log[1]
            StartDate = $log[2]
            EndDate = $log[3]
            Duration = [string]$dur.ToString("dd'd.'hh'h:'mm'm:'ss's'")
            LoggedOnUser = $log[4]
            ConnectionType = $log[5]
            ConnectionID = $log[6]
        }
    }
    if($IncomingID){
        $obj | Sort-Object -Property incomingid -Unique | select-object incomingid
    }
    elseif($DisplayName){
        $obj | Sort-Object -Property displayname -Unique | select-object displayname
    }
    elseif($LoggedOnUser){
        $obj | Sort-Object -Property LoggedOnUser -Unique | select-object LoggedOnUser
    }
}

function Get-TVLogFile_RunTimes{
<#
.SYNOPSIS
    Parses the Teamviewer15_logfile.log and Teamviewer15_logfile_OLD.log for the run time of the Teamviewer program

.PARAMETER directory
    Used to specify the directory containing the log files

.EXAMPLE
    Get-TVLogFile_RunTimes -directory "C:\Program Files (x86)\TeamViewer"

    Will search the specified directory and parse the log files, returning the run time of the Teamviewer program
#>
    [CmdletBinding()]
    param(
        $directory
    )
    $logs = Get-ChildItem ($directory + "\teamviewer15_Logfile*.log")

    $obj = @()
    $obj = foreach($line in $logs.fullname){
        $logfile = Get-Content $line | select-string -Pattern '(2]::processconnected:) | (Closing TeamViewer)'
        
        foreach($item in $logfile){
            $data = $shutdownData = ' '
            if ($item -like "*2]::processconnected: *"){
                $data = $item.line -split ' '
                $data = $data[0]+' '+$data[1]
                $data = ([datetime]$data).ToString("MM/dd/yyyy HH:mm:ss")
                $index = ($logfile.IndexOf($item) + 1)
                if($logfile[$index] -match "Closing Teamviewer"){
                    $shutdownData = $item.line -split ' '
                    $shutdownData = $shutdownData[0]+' '+$shutdownData[1]
                    $shutdownData = ([datetime]$shutdownData).ToString("MM/dd/yyyy HH:mm:ss")
                }
                [pscustomobject]@{
                    ProgramStart = $data
                    ProgramEnd = $shutdownData
                }
            }
        }
    }
}

function Get-TVLogFile_AccountLogons{
<#
.SYNOPSIS
    Parses the Teamviewer15_logfile.log and Teamviewer15_logfile_OLD.log for the account names

.PARAMETER directory
    Used to specify the directory containing the log files

.EXAMPLE
    Get-TVLogFile_AccountLogons -directory "C:\Program Files (x86)\TeamViewer"

    Returns the account names

#>
    [CmdletBinding()]
    param(
        $directory
    )

    $logs = Get-ChildItem ($directory + "\teamviewer15_Logfile*.log")

    $obj = @()
    $obj = foreach($line in $logs.fullname){
        $logfile = Get-Content $file | select-string -Pattern "HandleLoginFinished: Authentication successful", "Account::Logout: Account session terminated successfully"
        foreach($item in $logfile){
            $data = $logoutData = ' '
            if ($item.Matches.value -like "*authentication*"){
                $data = $item.line -split ' '
                $data = $data[0]+' '+$data[1]
                $data = ([datetime]$data).ToString("MM/dd/yyyy HH:mm:ss")

            }
            else{
                $Data = "--"
            }
            if($item.Matches.value -like "*terminated*"){
                $logoutData = $item.line -split ' '
                $logoutData = $logoutData[0]+ ' '+$logoutData[1]
                $logoutData = ([datetime]$logoutData).ToString("MM/dd/yyyy hh:mm:ss")
            }
            else{
                $logoutData = "--"
            }
            [pscustomobject]@{
                AccountLogon = $data
                AccountLogout = $logoutData
            }
        } 
    }
}

function Get-TVLogFile_IPs{
<#
.SYNOPSIS
    Parses the Teamviewer15_logfile.log and Teamviewer15_logfile_OLD.log for a list of IPs used for incoming connections

.PARAMETER directory
    Used to specify the directory containing the log files

.EXAMPLE
    Get-TVLogFile_IPs -directory "C:\Program Files (x86)\TeamViewer"

    Returns the IPs used during the incoming connections
#>
    [CmdletBinding()]
    param(
        $directory
    )

    $logs = Get-ChildItem ($directory + "\teamviewer15_Logfile*.log")

    $obj = @()
    $obj = foreach($logfile in $logs.fullname){
        $temp = get-content $logfile | select-string "punch\sreceived.*?[0-9]{3}\.[0-9]{3}\.[0-9]{1,}\.[0-9]{1,}\:.*?\:", "punch\sreceived.*?a=.*?\:[0-9]{5}\:"
        foreach($line in $temp){
            try{
                $tempSplit = $line -split ('=')
                $date = $data = ($line -split(''))[0..19] -join('')
                $date = ([datetime]$date).ToString("MM/dd/yyyy HH:mm:ss")
                if($tempSplit[1].length -gt 22){
                    $ip = $tempSplit[1].trim(': (*)') 
                    $comm[0] = $ip[0..(($ip).length - 7)] -join('')
                    $comm[1] = $ip[-5..-1] -join('')
                }
                else{
                    $comm = ($tempSplit[1].trim(': (*)')) -split (':')
                }
            } catch{ }

            [pscustomobject]@{
                Date = $date
                IP = $comm[0]
                SrcPort = $comm[1]
            }
        }
    }
}

Function Get-TVLogFile_PIDs{
<#
.SYNOPSIS
    Parses the Teamviewer15_logfile.log and Teamviewer15_logfile_OLD.log and returns the PID for the connection

.PARAMETER directory
    Used to specify the directory containing the log files

.EXAMPLE
    Get-TVLogFile_PIDs -directory "C:\Program Files (x86)\TeamViewer"

    Returns the PIDs associated with the incoming connection
#>
    [CmdletBinding()]
    param(
        $directory
    )

    $logs = Get-ChildItem ($directory + "\teamviewer15_Logfile*.log")
    
        $obj = @()
        $obj = foreach($log in $logs.fullname){
            $temp = get-content $log | select-string "Start Desktop process"
            foreach($line in $temp){
                $split = $line -Split(' ')
                $data = $split[0]+' '+$split[1]
                $data = ([datetime]$data).ToString("MM/dd/yyyy HH:mm")
                [pscustomobject]@{
                    Date = $data
                    PID = $split[-1]
                }
            }
        }
    }
    
Function Get-TVLogFile_Outgoing{
<#
.SYNOPSIS
    Parses the Teamviewer15_logfile.log and Teamviewer15_logfile_OLD.log and returns outgoing connections (successes and failures)

.PARAMETER directory
    Used to specify the directory containing the log files

.EXAMPLE
    Get-TVLogFile_Outgoing -directory "C:\Program Files (x86)\TeamViewer"

    Returns the outgoing connections (successes and failures)
#>
    [CmdletBinding()]
    param(
        $directory
    )
    $logs = Get-ChildItem ($directory + "\teamviewer15_Logfile*.log")
    
        $obj = @()
      $obj =  foreach($log in $logs.fullname){
            $temp = get-content $log | select-string "trying connection to", "LoginOutgoing: ConnectFinished - error: KeepAliveLost" 
            foreach($line in $temp){
                $tvID = $success = ' '
                $split = $line -Split(' ')
                if($line -like "*mode = 1"){
                    $tvID = ($split[-4]).trim(',') 
                    $index = ($temp.IndexOf($line) + 1)
                    if($temp[$index] -match "KeepAliveLost"){
                        $success = "No"
                    }
                    else{
                        $success = "Yes"
                    }
                $data = $split[0]+' '+$split[1]
                $data = ([datetime]$data).ToString("MM/dd/yyyy HH:mm:ss")
                [pscustomobject]@{
                    Date = $data
                    ID = $tvID
                    Successful = $success
                   # Duration = 
                }
               
                }
                else{
                   
                }

            }
        }
    }

Function Get-TVLogFile_KeyboardLayout{
<#
.SYNOPSIS
    Parses the Teamviewer15_logfile.log and Teamviewer15_logfile_OLD.log and returns the keyboard layout associated with the incoming connection

.PARAMETER directory
    Used to specify the directory containing the log files

.EXAMPLE
    Get-TVLogFile_KeyboardLayout -directory "C:\Program Files (x86)\TeamViewer"

    Reurtns the keyboard layout associated with the incoming connection
#>    
    [CmdletBinding()]
    param(
        $directory
    )
    
    $logs = Get-ChildItem ($directory + "\teamviewer15_Logfile*.log")
    
        $obj = @()
        $obj = foreach($log in $logs.fullname){
            $temp = get-content $log | select-string "changing keyboard layout to"
            foreach($line in $temp){
                $split = $line -Split(' ')
                $data = $split[0]+' '+$split[1]
                $data = ([datetime]$data).ToString("MM/dd/yyyy HH:mm")
                [pscustomobject]@{
                    Date = $data
                    Keyboard = $split[-1]
                }
            }
        }
    }

function Get-TVConnectionsLog_byDate{
<#
.SYNOPSIS
    Parses the connections.txt and returns data before, after, or between a specific date

.DESCRIPTION
    Location to the connections.txt file

.PARAMETER BeforeDate
    Returns data before the specified date

.PARAMETER AfterDate
    Returns data after the specified date

.EXAMPLE
    Get-TVConnectionsLog_byDate -file "C:\Users\<user>\AppData\Roaming\TeamViewer\connections.txt" -before "12/25/2020"
   
    Returns data before December 25, 2020

.EXAMPLE
    Get-TVConnectionsLog_byDate -file "C:\Users\<user>\AppData\Roaming\TeamViewer\connections.txt" -after "12/25/2020"
    
    Returns data after December 25, 2020

.EXAMPLE
    Get-TVConnectionsLog_byDate -file "C:\Users\<user>\AppData\Roaming\TeamViewer\connections.txt" -before "3/1/2021" -after "12/25/2020"
    
    Returns data after March 1, 2021 before December 25, 2020
#>
    [CmdletBinding()]
    param(
        $File,
        $BeforeDate,
        $AfterDate
    )
    $logs = get-content $file

    $obj = @()
    $obj = foreach($log in $logs){
        $dur = ''
        $log = $log -split '\s+'
        $dataStart = $log[1]+' '+$log[2]
        $dataEnd = $log[3]+' '+$log[4]
        try{
            $dataStart = [datetime]::ParseExact($dataStart,'dd-MM-yyyy HH:mm:ss', $null)
        } catch { }
        try{
            $dataEnd = [datetime]::ParseExact($dataEnd,'dd-MM-yyyy HH:mm:ss', $null) 
        } catch { }
        try{
            $dur = New-TimeSpan -start $dataStart -end $dataEnd -ErrorAction SilentlyContinue
            [PSCustomObject]@{
                IncomingID = $log[0]
                StartDate = $dataStart
                EndDate = $dataEnd
                Duration = [string]$dur.ToString("dd'd.'hh'h:'mm'm:'ss's'")
                LoggedOnUser = $log[5]
                ConnectionType = $log[6]
                ConnectionID = $log[7]
            }
        } catch { }
    }

    if($afterDate -and $beforeDate){
        $obj |where-object{$_.startdate -gt $afterDate -and $_.startdate -lt $beforeDate}
    }
    elseif($afterDate){
        $obj |where-object{$_.startdate -gt $afterDate}
    }
    elseif($beforeDate){
        $obj |where-object{$_.startdate -lt $beforeDate}
    }
}

function Get-TVConnectionsLog_Top10Duration{
<#
.SYNOPSIS
    Parses the connections.txt file and returns the duration for the top 10 longest or shortest outgoing connections

.PARAMETER File
    Location to the connections.txt file

.PARAMETER shortest
    Used select the shortest connections

.PARAMETER longest
    Used select the longest connections

.EXAMPLE
    Get-TVConnectionsLog_Top10Duration -file "C:\Users\<user>\AppData\Roaming\TeamViewer\connections.txt" 

    Returns the duration for all outgoing connections

.EXAMPLE
    Get-TVConnectionsLog_Top10Duration -file "C:\Users\<user>\AppData\Roaming\TeamViewer\connections.txt" -shortest

    Returns the top 10 shortest durations for all outgoing connections

.EXAMPLE
    Get-TVConnectionsLog_Top10Duration -file "C:\Users\<user>\AppData\Roaming\TeamViewer\connections.txt" -longest

    Returns the top 10 longest durations for all outgoing connections
#>
    [CmdletBinding()]
    param(
        $file,
        [switch]$shortest,
        [switch]$longest
    )
    $logs = get-content $file

    $obj = @()

    $obj = foreach($log in $logs){
        $dur = ''
        $log = $log -split '\s+'
        $dataStart = $log[1]+' '+$log[2]
        $dataEnd = $log[3]+' '+$log[4]
        try{
            $dataStart = [datetime]::ParseExact($dataStart,'dd-MM-yyyy HH:mm:ss', $null)
        } catch { }
        try{
            $dataEnd = [datetime]::ParseExact($dataEnd,'dd-MM-yyyy HH:mm:ss', $null) 
        } catch { }
        try{
            $dur = New-TimeSpan -start $dataStart -end $dataEnd -ErrorAction SilentlyContinue
            [PSCustomObject]@{
                IncomingID = $log[0]
                StartDate = $dataStart
                EndDate = $dataEnd
                Duration = [string]$dur.ToString("dd'd.'hh'h:'mm'm:'ss's'")
                LoggedOnUser = $log[5]
                ConnectionType = $log[6]
                ConnectionID = $log[7]
            }
        } catch { } 
    }
    if($shortest){
        $obj | Sort-Object Duration -Top 10 | Format-Table
    }
    if($longest){
        $obj | Sort-Object Duration -Bottom 10 | Format-Table
    }
}
