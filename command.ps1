#do something

#Dump all the environmental variables to stdout, usually only for debugging
if ($env:dump_env_vars -eq $true) {
    Write-Host (Get-ChildItem variable:$env)
}
