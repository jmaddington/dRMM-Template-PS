cd ..
copy build\resource.xml
del aem-component.cpt
.\bin\7zip\7z.exe a  aem-component.cpt -tzip command.bat resource.xml .\bin\*
del resource.xml