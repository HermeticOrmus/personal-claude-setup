# install-mcp-monitor-service.ps1 - Windows Task Scheduler Setup for MCP Monitoring
# Run as Administrator

$ErrorActionPreference = "Stop"

$HermeticRoot = "$env:USERPROFILE\.hermetic"
$ServiceScript = "$HermeticRoot\maintenance\mcp-monitor-service.sh"
$TaskName = "HermeticMCPMonitor"

function Write-ColorOutput {
    param([string]$Message, [string]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

function Find-GitBash {
    $paths = @(
        "C:\Program Files\Git\bin\bash.exe",
        "C:\Program Files (x86)\Git\bin\bash.exe",
        "$env:LOCALAPPDATA\Programs\Git\bin\bash.exe"
    )
    foreach ($path in $paths) {
        if (Test-Path $path) { return $path }
    }
    throw "Git Bash not found"
}

Write-ColorOutput "═══════════════════════════════════════════════════" "Blue"
Write-ColorOutput "  Hermetic MCP Monitor - Setup" "Blue"
Write-ColorOutput "═══════════════════════════════════════════════════" "Blue"

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-ColorOutput "⚠ Must run as Administrator" "Red"
    exit 1
}

$bashPath = Find-GitBash
$scriptPathUnix = $ServiceScript -replace '\\', '/' -replace 'C:', '/c'

# Remove existing task
$existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
if ($existingTask) {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

# Create task that runs at startup
$action = New-ScheduledTaskAction -Execute $bashPath -Argument "$scriptPathUnix start"
$trigger = New-ScheduledTaskTrigger -AtStartup
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 5)
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType S4U

Register-ScheduledTask -TaskName $TaskName -Description "Hermetic MCP health monitoring service" -Action $action -Trigger $trigger -Settings $settings -Principal $principal | Out-Null

Write-ColorOutput "`n✓ MCP Monitor service installed" "Green"
Write-ColorOutput "  Will start automatically on system boot" "White"
Write-ColorOutput "`nStart manually: bash mcp-monitor-service.sh start" "Cyan"
