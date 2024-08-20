@REM This will package everything in the parent folder EXCEPT the build components themselves, and the bin folder
@REM Relative paths will be preserved

cd ..
copy build\resource.xml
copy command.ps1 command.bat
del aem-component.cpt
.\bin\7zip\7z.exe a  aem-component.cpt -tzip * -x!.git/ -x!initialize/ -x!build/ -x!bin/
del resource.xml
del command.bat
