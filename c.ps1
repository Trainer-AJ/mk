$startDate = Get-Date "2025-06-03 00:00:00"
$endDate = Get-Date "2025-06-04 00:00:00"
 
$providers = @(
    "W3SVC",
    "WAS",
    "IISADMIN",
    "ASP.NET",
    "ASP.NET 4.0.30319.0",
    ".NET Runtime",
    "Application Error",
    "HTTPERR"
)
 
Get-WinEvent -FilterHashtable @{
    LogName = 'Application'
    ProviderName = $providers
    StartTime = $startDate
    EndTime = $endDate
    Level = 2  # Error level
} | Format-Table TimeCreated, ProviderName, Id, Message -AutoSize
