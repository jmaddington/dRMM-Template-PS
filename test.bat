@REM necessary because AEM has files named "comamnd.bat"

copy .\command.bat .\command.ps1

powershell .\command.ps1

del .\command.ps1