# Get current date and time
$datetime = Get-Date 

# Define source and destination paths
$sourcePath = "E:\FusionInvest\Batches\DataWarehouseExtractions\DW_Folio\generatedReports\DataWarehouse\Folio"
$destinationPath = "F:\ArchiveBatchDataFiles\DW_PerfViewReport"
$logFile = "C:\Users\e11491t1\Downloads\logfile.txt"

# Exit if today is not Sunday
if ($datetime.DayOfWeek -ne 'Sunday') {
    Write-Host "Today is not Sunday. Exiting script."
    exit
}

# Calculate the date range for the week before last Sunday
$lastSunday = $datetime.AddDays(-7)
$startDate = $lastSunday.AddDays(-7).Date
$endDate = $lastSunday.Date.AddSeconds(-1)

Write-Host "Start Date: $startDate"
Write-Host "End Date: $endDate"
Write-Host "Copying files modified between $startDate and $endDate..."

# Ensure destination folder exists
if (-not (Test-Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null
}

# Initialize error collection
$errors = @()

# Get and copy files modified in the date range
Get-ChildItem -Path $sourcePath -Recurse -File | Where-Object {
    $_.LastWriteTime -ge $startDate -and $_.LastWriteTime -le $endDate
} | ForEach-Object {
    try {
        $target = Join-Path $destinationPath $_.Name
        Copy-Item $_.FullName -Destination $target -Force
    } catch {
        $errors += "Error copying file '$($_.FullName)': $($_.Exception.Message)"
    }
}

Write-Host "Files copied successfully."

# Append log entry
$logEntry = @"
[$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")] Script executed.
Files copied for:
Start Date: $startDate
End Date: $endDate
Errors:
$($errors -join "`n")
"@

Add-Content -Path $logFile -Value $logEntry
