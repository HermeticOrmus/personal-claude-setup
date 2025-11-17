# setup-session-archival.ps1 - Session Archival Task Scheduler
$ErrorActionPreference = "Stop"

$HermeticRoot = "$env:USERPROFILE\.hermetic"
$Script = "$HermeticRoot\maintenance\archive-old-sessions.sh"
$TaskName = "HermeticSessionArchival"

function Find-GitBash {
    $paths = @("C:\Program Files\Git\bin\bash.exe", "C:\Program Files (x86)\Git\bin\bash.exe")
    foreach ($p in $paths) { if (Test-Path $p) { return $p } }
    throw "Git Bash not found"
}

$bashPath = Find-GitBash
$scriptUnix = $Script -replace '\\', '/' -replace 'C:', '/c'

$action = New-ScheduledTaskAction -Execute $bashPath -Argument $scriptUnix
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 3am
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType S4U

$task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
if ($task) { Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false }

Register-ScheduledTask -TaskName $TaskName -Description "Archive old Claude sessions weekly" -Action $action -Trigger $trigger -Settings $settings -Principal $principal | Out-Null

Write-Host "✓ Session archival scheduled (Sundays at 3 AM)" -ForegroundColor Green
