# setup-automated-backups.ps1 - Windows Task Scheduler Setup for Backups
# Part of the Hermetic Automation Infrastructure
# Run as Administrator

$ErrorActionPreference = "Stop"

# ============================================================================
# CONFIGURATION
# ============================================================================

$HermeticRoot = "$env:USERPROFILE\.hermetic"
$BackupScript = "$HermeticRoot\maintenance\automated-backup-wrapper.sh"
$TaskName = "HermeticAutomatedBackup"
$TaskDescription = "Hermetic daily automated backup at 2 AM"

# ============================================================================
# COLORS
# ============================================================================

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# ============================================================================
# GIT BASH DETECTION
# ============================================================================

function Find-GitBash {
    Write-ColorOutput "Detecting Git Bash..." "Cyan"

    $possiblePaths = @(
        "C:\Program Files\Git\bin\bash.exe",
        "C:\Program Files (x86)\Git\bin\bash.exe",
        "$env:LOCALAPPDATA\Programs\Git\bin\bash.exe"
    )

    foreach ($path in $possiblePaths) {
        if (Test-Path $path) {
            Write-ColorOutput "  ✓ Found Git Bash: $path" "Green"
            return $path
        }
    }

    Write-ColorOutput "  ✗ Git Bash not found in standard locations" "Red"
    Write-ColorOutput "  Please enter the path to bash.exe manually:" "Yellow"
    $customPath = Read-Host "  Path to bash.exe"

    if (Test-Path $customPath) {
        return $customPath
    } else {
        throw "Git Bash not found at: $customPath"
    }
}

# ============================================================================
# TASK CREATION
# ============================================================================

function Create-BackupTask {
    param(
        [string]$BashPath
    )

    Write-ColorOutput "`nCreating scheduled task..." "Cyan"

    # Convert Windows path to Git Bash path
    $scriptPathUnix = $BackupScript -replace '\\', '/' -replace 'C:', '/c'

    # Task action
    $action = New-ScheduledTaskAction `
        -Execute $BashPath `
        -Argument "$scriptPathUnix"

    # Task trigger - Daily at 2 AM
    $trigger = New-ScheduledTaskTrigger -Daily -At 2am

    # Task settings
    $settings = New-ScheduledTaskSettingsSet `
        -AllowStartIfOnBatteries `
        -DontStopIfGoingOnBatteries `
        -StartWhenAvailable `
        -RunOnlyIfNetworkAvailable:$false

    # Task principal (run whether user is logged on or not)
    $principal = New-ScheduledTaskPrincipal `
        -UserId "$env:USERDOMAIN\$env:USERNAME" `
        -LogonType S4U `
        -RunLevel Limited

    # Register the task
    try {
        # Remove existing task if it exists
        $existingTask = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
        if ($existingTask) {
            Write-ColorOutput "  Removing existing task..." "Yellow"
            Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
        }

        Register-ScheduledTask `
            -TaskName $TaskName `
            -Description $TaskDescription `
            -Action $action `
            -Trigger $trigger `
            -Settings $settings `
            -Principal $principal | Out-Null

        Write-ColorOutput "  ✓ Scheduled task created successfully" "Green"
        return $true
    }
    catch {
        Write-ColorOutput "  ✗ Failed to create scheduled task: $_" "Red"
        return $false
    }
}

# ============================================================================
# VERIFICATION
# ============================================================================

function Test-TaskSetup {
    Write-ColorOutput "`nVerifying task setup..." "Cyan"

    $task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue

    if (-not $task) {
        Write-ColorOutput "  ✗ Task not found" "Red"
        return $false
    }

    Write-ColorOutput "  ✓ Task exists" "Green"
    Write-ColorOutput "  Task Name: $($task.TaskName)" "White"
    Write-ColorOutput "  State: $($task.State)" "White"

    $trigger = $task.Triggers[0]
    if ($trigger) {
        Write-ColorOutput "  Schedule: Daily at $($trigger.StartBoundary.Split('T')[1].Substring(0,5))" "White"
    }

    return $true
}

# ============================================================================
# MANUAL TEST
# ============================================================================

function Test-BackupManually {
    param(
        [string]$BashPath
    )

    Write-ColorOutput "`nWould you like to run a test backup now? (y/n): " "Yellow" -NoNewline
    $response = Read-Host

    if ($response -eq 'y') {
        Write-ColorOutput "`nRunning test backup..." "Cyan"

        $scriptPathUnix = $BackupScript -replace '\\', '/' -replace 'C:', '/c'

        try {
            & $BashPath $scriptPathUnix
            Write-ColorOutput "`n  ✓ Test backup completed" "Green"
        }
        catch {
            Write-ColorOutput "`n  ✗ Test backup failed: $_" "Red"
        }
    }
}

# ============================================================================
# MAIN
# ============================================================================

function Main {
    Write-ColorOutput "═══════════════════════════════════════════════════" "Blue"
    Write-ColorOutput "  Hermetic Automated Backup - Setup" "Blue"
    Write-ColorOutput "═══════════════════════════════════════════════════" "Blue"
    Write-ColorOutput ""

    # Check if running as Administrator
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $isAdmin) {
        Write-ColorOutput "⚠ This script must be run as Administrator" "Red"
        Write-ColorOutput "  Right-click PowerShell and select 'Run as Administrator'" "Yellow"
        Write-ColorOutput ""
        Read-Host "Press Enter to exit"
        exit 1
    }

    # Check if backup script exists
    if (-not (Test-Path $BackupScript)) {
        Write-ColorOutput "✗ Backup script not found: $BackupScript" "Red"
        Write-ColorOutput "  Please ensure all automation scripts are installed" "Yellow"
        Write-ColorOutput ""
        Read-Host "Press Enter to exit"
        exit 1
    }

    Write-ColorOutput "✓ Backup script found" "Green"
    Write-ColorOutput ""

    # Find Git Bash
    try {
        $bashPath = Find-GitBash
    }
    catch {
        Write-ColorOutput "`n✗ Error: $_" "Red"
        Read-Host "Press Enter to exit"
        exit 1
    }

    # Create scheduled task
    $taskCreated = Create-BackupTask -BashPath $bashPath

    if (-not $taskCreated) {
        Write-ColorOutput "`n✗ Setup failed" "Red"
        Read-Host "Press Enter to exit"
        exit 1
    }

    # Verify setup
    $verified = Test-TaskSetup

    if ($verified) {
        Write-ColorOutput "`n═══════════════════════════════════════════════════" "Green"
        Write-ColorOutput "  Setup Complete!" "Green"
        Write-ColorOutput "═══════════════════════════════════════════════════" "Green"
        Write-ColorOutput ""
        Write-ColorOutput "Automated backups will run daily at 2:00 AM" "White"
        Write-ColorOutput ""
        Write-ColorOutput "Manage the task:" "Cyan"
        Write-ColorOutput "  • Task Scheduler → Task Scheduler Library → $TaskName" "White"
        Write-ColorOutput "  • Or run: Get-ScheduledTask -TaskName $TaskName" "White"
        Write-ColorOutput ""
        Write-ColorOutput "Check backup status:" "Cyan"
        Write-ColorOutput "  bash check-backup-status.sh" "White"
        Write-ColorOutput ""

        # Offer manual test
        Test-BackupManually -BashPath $bashPath
    }
    else {
        Write-ColorOutput "`n✗ Verification failed" "Red"
    }

    Write-ColorOutput ""
    Read-Host "Press Enter to exit"
}

Main
