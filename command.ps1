#Generic function to gracefully exit dRMM PowerShell script
#@param exitcode: mandatory, code to exit with; 0=success, 1=failure
#@param results: string or integer to pass back to dRMM for results of script
#@param diagnostics: additional information to pass back to dRMM for results of script
function Exit-dRMMScript {
    [cmdletbinding()]
    Param([Parameter(Mandatory=$true)]$exitcode, $results, $diagnostics)

    #Output results
    Write-Output "<-Start Result->"
    Write-Output "Result=$results"
    Write-Output "<-End Result->"

    #Output diagnostics, if they exist
    if (!($null -eq $diagnostics)) {
        Write-Output "<-Start Diagnostics->"
        Write-Output "Result=$diagnostics"
        Write-Output "<-End Result->"
    }

    exit $exitcode

} #End function

#Generic function to set dRMM UDF
#@param udf_number: mandatory, UDF number to set
#@param udf_value: mandatory, value to set UDF to
function Set-dRMM-UDF {
    Param([Parameter(Mandatory=$true)]$udf_number, $udf_value)
    REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\CentraStage /v "Custom$udf_number" /t REG_SZ /d "$udf_value" /f
}

#Dump all the environmental variables to stdout, usually only for debugging
if ($env:drmm_dump_env_vars -eq "true") {
    Get-ChildItem variable:$env | ForEach-Object {
        Write-Output $_
    }
}

Set-Variable -Name EXIT_SUCCESS -Value 0 -Option Constant
Set-Variable -Name EXIT_FAILURE -Value 1 -Option Constant

########################################
##### Begin custom script section ######
########################################

# Do things

Write-Output $hello_world_var


Exit-dRMMScript -exitcode $EXIT_SUCCESS -results "Success!" -diagnostics "Additional info here"
