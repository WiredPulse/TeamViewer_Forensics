function Get-TVIncomingLog_byDate{
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
