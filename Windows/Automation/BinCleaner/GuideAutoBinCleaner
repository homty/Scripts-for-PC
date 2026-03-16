# PowerShell Scheduled Task for Automatic Trash Bin Cleanup

This document provides a PowerShell script to automate the cleanup of the Windows Recycle Bin by creating a scheduled task. Below is a breakdown of the script and the commands used to manage the task.

## Script Description

The script sets up a recurring task that automatically runs a PowerShell cleanup script (`TrashCleanup.ps1`) every week (Monday 20:00/8:00pm).

### Task Action (`$action`)
This section defines what the scheduled task will do.

```powershell
$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File `"C:\Scripts\TrashCleanup.ps1`""
```

- **`-Execute "powershell.exe"`**: Specifies that the task will run PowerShell.
- **`-Argument`**: Provides the arguments for `powershell.exe`:
  - **`-NonInteractive`**: Ensures the script doesn't prompt for user input.
  - **`-WindowStyle Hidden`**: Hides the PowerShell window when the script runs.
  - **`-ExecutionPolicy Bypass`**: Temporarily bypasses the execution policy to allow the script to run.
  - **`-File "C:\Scripts\TrashCleanup.ps1"`**: The path to the script that will be executed. **Note:** You must change this path to where your script is located.

### Task Trigger (`$trigger`)
This section defines when the task will run.

```powershell
$trigger = New-ScheduledTaskTrigger `
    -Weekly `
    -DaysOfWeek Monday `
    -At "20:00"
```

- **`-Weekly`**: Sets the task to run on a weekly basis.
- **`-DaysOfWeek Monday`**: Specifies that the task will run every Monday.
- **`-At "20:00"`**: Sets the time for the task to run at 8:00 PM (20:00).

### Task Settings (`$settings`)
This section defines additional settings for the task's behavior.

```powershell
$settings = New-ScheduledTaskSettingsSet `
    -ExecutionTimeLimit (New-TimeSpan -Hours 1) `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable:$false
```

- **`-ExecutionTimeLimit`**: Sets a maximum run time for the task (in this case, 1 hour).
- **`-StartWhenAvailable`**: Allows the task to run as soon as possible after a scheduled start is missed.
- **`-RunOnlyIfNetworkAvailable:$false`**: Ensures the task runs even if there is no network connection.

### Registering the Task
This command creates and registers the scheduled task with the settings defined above.

```powershell
Register-ScheduledTask `
    -TaskName "TrashBinCleanup" `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -RunLevel Highest `
    -Force
```

- **`-RunLevel Highest`**: Runs the task with the highest privileges (administrator).
- **`-Force`**: Overwrites the task if it already exists.

## Managing the Scheduled Task

Here are some useful commands to manage the task after it has been created.

### Check the Task Status
To see the status and configuration of the scheduled task:

```powershell
Get-ScheduledTask -TaskName "TrashBinCleanup"
```

### Manually Start the Task
To run the task immediately, outside of its scheduled time:

```powershell
Start-ScheduledTask -TaskName "TrashBinCleanup"
```

### Remove the Task
To delete the scheduled task from the system:

```powershell
Unregister-ScheduledTask -TaskName "TrashBinCleanup" -Confirm:$false
```

- **`-Confirm:$false`**: Prevents PowerShell from asking for confirmation before removing the task.
