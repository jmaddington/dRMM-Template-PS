#Get variables from Datto RMM

If (!($env:test -eq "true")) {
    If ($env:du_dir -eq $null ) {
        $du_dir = "C:\"
    } Else {
        $du_dir = $env:du_dir
    }

    If ($env:du_depth -eq $null ) {
        $du_depth = 2
    } Else {
        $du_depth = $env:du_depth
    }

    If ($env:du_output -eq $null ) {
        $du_output = "C:\jmaddington\du.txt"
    } Else {
        $du_output = $env:du_output
    }
} else {
    $du_dir = "C:\"
    $du_depth = 2
    $du_output = "C:\jmaddington\du.txt"
}

#Run du and output to appropriate directory.
.\du.exe -accepteula -nobanner -l $du_depth $du_dir > $du_output

#write output to stdout
Write-Host "<-Start Diagnostic->"
write-host(get-content($du_output))
Write-Host "<-End Diagnostic->"
exit 0