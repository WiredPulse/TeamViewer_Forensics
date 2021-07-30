$logs = (get-content c:\users\nandy\downloads\connections_incoming.txt)

$obj = @()
$logs = $logs -replace (' ','_')
$obj = foreach($log in $logs){
    $log = $log -split "\s+"
    [PSCustomObject]@{
        IncomingID = $log[0]
        DisplayName = $log[1]
        StartTime = $log[2]
        EndTime = $log[3]
        LoggedOnUser = $log[4]
        ConnectionType = $log[5]
        ConnectionID = $log[6]
    }
}

$obj | format-table

foreach($a in $obj){
$a -replace ("fernando11011", "PC1")
}
