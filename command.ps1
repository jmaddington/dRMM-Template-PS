#Generic function to check variables in dRMM PowerShell script
#@param $site_variable: the value of the site/account level variable to check
#@param $script_variable: the value of the script level variable to check
#@param $exit_if_missing: set to $true is variable is required to finish the script
#@param $exit_message: message to output if script is erroring out
#@param $warning_message: message to output if script has variable related error but will continue
#@param $default: default value to return
function Get-dRMMVariable {
    [cmdletbinding()]
    Param($site_variable,
    $script_variable,
    [boolean]$exit_if_missing = $true,
    $exit_message,
    $warning_message,
    $default)

    #Check to see if NO variable value has been passed as either account, site or script level
    If ($null -eq $site_variable -and $null -eq $script_variable) {
        #If no variable has been passed and this is mandatory, exit
        if ($exit_if_missing) {
            $exitcode = 1
            dRMM-ExitScript -exitcode $exitcode -results $exit_message
        } else {
            #Otherwise throw a warning and carry on
            if (!($null -eq $warning_message)) { Write-output $warning_message}
            
            #Return a default value if set
            If (!($null -eq $default)) { return $default }
        }
    }

    #Check to see if the script level variable is set to 0, indicating that a site/acct level variable should be used
    #but site/account level variable is missing
    If ($script_variable -eq 0 -and $null -eq $site_variable) {
        #If no variable has been passed and this is mandatory, exit
        if ($exit_if_missing) {
            $exitcode = 1
            Exit-dRMMScript -exitcode $exitcode -results $exit_message
        } else {
            #Otherwise throw a warning and carry on
            if (!($null -eq $warning_message)) { Write-output $warning_message}
        }
    }

    #Finally, we should have tested for all other options above. Return script_variable, if set, otherwise
    #return the site/acct variable
    If (!($script_variable -eq 0)) {
        return $script_variable
    } else {
        return $site_variable
    }

} #End function

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

#Dump all the environmental variables to stdout, usually only for debugging
if ($env:drmm_dump_env_vars -eq "true") {
    Get-ChildItem variable:$env | ForEach-Object {
        Write-Output $_
    }
}

########################################
##### Begin custom script section ######
########################################

#Check to see if we are in test mode, usually for for local for dev
If (!($env:test -eq "true")) {

    #Get variables
    $hello_world_var = Get-DdRMMVariable -site_variable $env:hello_world_var -script_variable $env:script_hello_world_var -exit_if_missing $false -warning "Hello World value not set, continuing" -default "Hello world!"

} else {

    #We're in test mode, manually set variables
    $hello_world_var = "Hello all y'all!"

}

# Do things

Write-Output $hello_world_var

#Exit with success, to exit with failure use $exitcode = 1
$exitcode = 0

Exit-dRMMScript -exitcode $exitcode -results "Success!" -diagnostics "Additional info here"