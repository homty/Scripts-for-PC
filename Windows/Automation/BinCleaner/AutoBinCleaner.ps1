param (
    [double]$MaxSizeGB = 5
)

Write-Host "Starting trash bin cleanup..."
Write-Host "Maximum size set to $MaxSizeGB GB."

try {
    $sid = [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
    $recycleBinPath = "C:\`$Recycle.Bin\$sid"

    $folderSize = [long]0

    if (Test-Path $recycleBinPath) {
        Write-Host "Checking items in recycle bin..."
        Get-ChildItem $recycleBinPath -Force -ErrorAction SilentlyContinue | ForEach-Object {
            $itemSize = [long]0
            Get-ChildItem $_.FullName -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
                $itemSize += [long]$_.Length   # cast each file individually to long
            }
            $itemSize += [long]$_.Length       # include the item itself if it's a file
            Write-Host "  - $($_.Name): $itemSize bytes"
            $folderSize += $itemSize
        }
    }

    $folderSizeGB = $folderSize / 1GB
    Write-Host "Current trash bin size: $($folderSizeGB.ToString("F2")) GB"

    if ($folderSizeGB -gt $MaxSizeGB) {
        Write-Host "Trash bin size exceeds the limit. Emptying trash bin..."
        Clear-RecycleBin -Force
        Write-Host "Trash bin emptied successfully."
    } else {
        Write-Host "Trash bin size is within the limit."
    }
}
catch {
    Write-Host "An error occurred: $_"
}

Write-Host "Trash bin cleanup finished."