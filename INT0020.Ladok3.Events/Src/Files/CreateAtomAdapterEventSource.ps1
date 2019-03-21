$source = "AtomAdapter"
$log = "Application"

 if ([System.Diagnostics.EventLog]::SourceExists($source) -eq $false) 
 {
        Write-host "Creating event source $source on event log $log"
        [System.Diagnostics.EventLog]::CreateEventSource($source, $log)
        Write-host -foregroundcolor green "Event source $source created"
 }