Write-Host "This will overwrite the existing resource.xml file. If you don't want to do that, stop now."

$continue = Read-Host "Continue? [yes] / no"

If ($continue -ne "yes")
{
    Write-Host "Exiting"
    exit
}

$name = Read-Host 'What do you want to call the script?'
$description = Read-Host 'Please provide a brief description of the script.'

$uuid = [guid]::NewGuid()
$uuid = $uuid.Guid

Write-host "Generating resource.xml"
write-host "New UUID: $uuid"

$resource = [xml](get-content ..\build\resource.xml)
$resource.component.general.name = $name.ToString()
$resource.component.general.description = $description.ToString()
$resource.component.general.uid = $uuid.ToString()

$resource.Save(".\build\resource.xml")