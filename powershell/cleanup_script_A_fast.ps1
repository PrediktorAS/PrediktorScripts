# Verbose settings for transcription to local log file.
$VerbosePreference = "Continue"

# Verbose settings for transcription to local log file.
$ErrorActionPreference = "silentlycontinue"

# Date & Time for Log File Name 
$LogDate = get-date -format "dd-MM-yyyy_HH-mm"

# Objects for emptying recycle bin
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace(0xA)

# Start Logging
Start-Transcript -Path C:\RemoteScript_logs\$LogDate.log

# Stop the windows update service.
Get-Service -Name wuauserv | Stop-Service -Force -ErrorAction SilentlyContinue -Verbose

# Delete the contents of windows software distribution.
Get-ChildItem "C:\Windows\SoftwareDistribution\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose |
remove-item -force -recurse -ErrorAction SilentlyContinue -Verbose

# Delete the contents of the Windows Temp folder.
Get-ChildItem "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose |
remove-item -force -recurse -ErrorAction SilentlyContinue -Verbose

# Delete files and folders in users Temp folders.
Get-ChildItem "C:\users\*\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose | 
remove-item -force -recurse -ErrorAction SilentlyContinue -Verbose

# Deletefiles and folders in users Downloads folders.
Get-ChildItem "C:\users\*\Downloads\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose | 
remove-item -force -recurse -ErrorAction SilentlyContinue  -Verbose

# Delete files and folders in users Desktop folders.
Get-ChildItem "C:\users\*\Desktop\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose | 
remove-item -force -recurse -ErrorAction SilentlyContinue -Verbose

# Delete files and folders in users Documents folder.
Get-ChildItem "C:\users\*\Documents\*" -Recurse -Force -ErrorAction SilentlyContinue -Verbose | 
remove-item -force -recurse -ErrorAction SilentlyContinue -Verbose

# Delete all files and folders in users Temporary Internet Files.
Get-ChildItem "C:\users\*\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" `-Recurse -Force -ErrorAction SilentlyContinue -Verbose | 
remove-item -force -recurse -ErrorAction SilentlyContinue  -Verbose

# Clean IIS Logs.
Get-ChildItem "C:\inetpub\logs\LogFiles\*" -Recurse -Force -ErrorAction SilentlyContinue | 
Remove-Item -Force -Recurse -ErrorAction SilentlyContinue  -Verbose

# Delete the contents of the recycle bin.
$objFolder.items() | 
ForEach-Object { Remove-Item $_.path -ErrorAction Ignore -Force -Recurse -Verbose }

# Restart the Windows Update Service
Get-Service -Name wuauserv | Start-Service -Verbose

# Stop logging
Stop-Transcript
