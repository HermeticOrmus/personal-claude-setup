# setup-n8n-sync.ps1 - n8n Sync Task Scheduler
$ErrorActionPreference = "Stop"

$HermeticRoot = "$env:USERPROFILE\.hermetic"
$Script = "$HermeticRoot\maintenance\n8n-workflow-sync.sh"
$TaskName = "Hermeticn8nSync"

function Find-GitBash {
    $paths = @("C:\Program Files\Git\bin\bash.exe", "C:\Program Files (x86)\Git\bin\bash.exe")
    foreach ($p in $paths) { if (Test-Path $p) { return $p } }
    throw "Git Bash not found"
}

Write-Host "Setting up n8n workflow sync..." -ForegroundColor Blue

# Set environment variables at system level (requires admin)
if ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $apiKey = Read-Host "Enter N8N_API_KEY"
    $baseUrl = Read-Host "Enter N8N_BASE_URL (default: http://localhost:5678)"
    if ([string]::IsNullOrEmpty($baseUrl)) { $baseUrl = "http://localhost:5678" }

    [Environment]::SetEnvironmentVariable("N8N_API_KEY", $apiKey, "User")
    [Environment]::SetEnvironmentVariable("N8N_BASE_URL", $baseUrl, "User")
    Write-Host "✓ Environment variables set" -ForegroundColor Green
}

$bashPath = Find-GitBash
$scriptUnix = $Script -replace '\\', '/' -replace 'C:', '/c'

$action = New-ScheduledTaskAction -Execute $bashPath -Argument "$scriptUnix both"
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 15)
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -MultipleInstances IgnoreNew
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType S4U

$task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
if ($task) { Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false }

Register-ScheduledTask -TaskName $TaskName -Description "n8n workflow sync every 15 minutes" -Action $action -Trigger $trigger -Settings $settings -Principal $principal | Out-Null

Write-Host "✓ n8n sync scheduled (every 15 minutes)" -ForegroundColor Green
