# Overview #

This repo is a starter dRMM component.

Please note that it does change and evolve. In particular, I hope to update the build script to be a little more robust.

# Usage #

Run initialize\init1.ps1 interactively to build a new resource.xml

CD into .\build and run build\repackage.bat to turn it into an importable dRMM component.

# Building #

Download or fork, run repackage.bat and upload aem-component.cpt to dRMM. You can also download the aem-component.cpt straight from this repository and install in your dRMM instance.

# Conventions #

## Variables ##

$variable_underscore_style casing is to be used. Prefix all variables with something meaning to the script. For example, the starter script
might prefix all variables with $hello_world_var. This allows for variables to easily be set at the site or account level without fear of colliding with
othe scripts.

Variables that can reasonably be set at multiple levels should be prefixed with script, such as script_hello_world_var in resource.xml as well the script itself. For example, $script_hello_world_var.

The default script contained here has a function Get-dRMMVariable to compare these different variables and either return the correct one, a 
default value, or exit.

The most common way of settings $hello_world_var would be:

```powershell
Get-dRMMVariable -site_variable $env:hello_world_var -script_variable $env:script_hello_world_var -exit_if_missing $true -exit_message "Hello_world value not set, exiting"
```

### Site/Account vs Script Variables ###

These scripts are designed to be run as quickly as possible. In many cases, the primary variables can be stored either at the RMM account
or site variable, such as activation keys, hostnames, etc. In those cases, the variable convention hello_world_var is simply used. When that 
happens, hello_world_var is set _in the RMM site or account settings_ instead of the script.

If it is a variable that could either be set at site/account _or_ script level setting, that is when the _script_ prefix is added. Because of the
way dRMM handles variables it isn't possible to define a variable, even an empty one, at the script level and still potentially define it at a higher level, hence the prefixing.

As this script and function currently is setup, a value of 0 passed by the script will result in the script looking for that variable set at a higher level.

## Exiting ##

For consistency the variable $exitcode should always be set before calling an exit function. 0 indicates success, 1 failure.

The default script contained here has a function Exit-dRMMScript which will properly exit with the following parameters:
* -exitcode: 0 (success) or 1 (failure)
* -results: The results to output (typically an integer or a success/failure message)
* -diagnostics: Extra diagnostic information. We consider it best practice to return a value here, even if previous functions indiciate success. For instance, if you are unzipping files to a directory and that returns success, diagnostics may return the directory contents as confirmation that the unzip was successful.

_Every script should (1) set $exitcode at some point and (2) Exit-dRMMScript_

Example:
```powershell
Exit-dRMMScript -exitcode $exitcode -results "Success!" -diagnostics "Additional info here"
```

## Output ##

Use write-output instead of write-host. Because Datto support said so.