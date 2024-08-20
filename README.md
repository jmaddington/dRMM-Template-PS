# Overview

This repo is a starter dRMM component.

## Usage

Run initialize\init1.ps1 interactively to build a new resource.xml

CD into .\build and run build\repackage.bat to turn it into an importable dRMM component.

## Building

Download or fork, run repackage.bat and upload aem-component.cpt to dRMM. You can also download the aem-component.cpt straight from this repository and install in your dRMM instance.

_You do not need to build this__. You can just copy and paste the code from `command.ps1` into your own script as well.
The build is made if you need to include extra files or resources in your component.

## Exiting

For consistency the variable $exitcode should always be set before calling an exit function. 0 indicates success, 1 failure.

The default script contained here has a function Exit-dRMMScript which will properly exit with the following parameters:
* -exitcode: 0 (success) or 1 (failure)
    - There are two constants you can use for this: $EXIT_SUCCESS and $EXIT_FAILURE, that correspond to 0 and 1 respectively.
* -results: The results to output (typically an integer or a success/failure message)
* -diagnostics: Extra diagnostic information. We consider it best practice to return a value here, even if previous functions indicate success. For instance, if you are unzipping files to a directory and that returns success, diagnostics may return the directory contents as confirmation that the unzip was successful.

_Every script should (1) set $exitcode at some point and (2) Exit-dRMMScript_

Example:
```powershell
Exit-dRMMScript -exitcode $EXIT_SUCCESS -results "Success!" -diagnostics "Additional info here"
```

## Output

Use write-output instead of write-host. Because Datto support said so.