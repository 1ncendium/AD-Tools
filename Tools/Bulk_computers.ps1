# Clear the screen
cls

# Import required modules
Import-Module ActiveDirectory

# Information for the host
Write-Host "Started script for bulk computers..."


function AddComputers() {
    # Promt user for CSV file
    $filepath = Read-Host -Prompt "`nPlease enter your CSV file"

    if (Test-Path $filepath -PathType leaf) {
        echo "`nFile found !"
    } else {
        Write-Host "File not found.. try again"
        AddComputers
    }    

    # Import the file into a variable
    $computers = Import-Csv $filepath

    ForEach ($computer in $computers) {
        # Gather the computer's information
        $computerName = $computer.'Computer name'
        $OUpath = $computer.'Organizational Unit'

        # Create computer
        New-ADComputer -Name $computerName -Path $OUpath -Enabled $True
        echo "Computer $computername created"
    }
}

function DeleteComputers() {
    
    # Warn the user
    Write-Host "Are you sure you want to proceed? Deleting computers may cause data loss" -ForegroundColor Red
    $Continue = Read-Host -Prompt "Continue Y/n"

    if ($Continue -eq "Y")
        {cls}
    else {
        ."$PSScriptRoot\..\AD_tools.ps1"
    }

    # Promt user for txt file
    $file = Read-Host -Prompt "`nPlease enter your TXT file"

    if (Test-Path $file -PathType leaf) {
        echo "`nFile found !"
    } else {
        Write-Host "File not found.. try again"
        DeleteComputers
    }   

    # Import the file into a variable
    $computers = Get-Content -Path $file

    # Loop trough each row and disable each account
    ForEach ($computer in $computers) {

        Remove-ADComputer $computer -Confirm:$false
        echo "Deleted computer $computer"
    }
}

# Function Menu
function Menu() {
    Write-Host "
    Options :
    
    1. Bulk add computers
    2. Bulk delete computers
    3. Return    
    "
}

#Call menu
Menu

function Options() {

    # Promt user for option
    $Answer = Read-Host -Prompt "What would you like to do?"

    if ($Answer -eq "1") {
        AddComputers
    } elseif ($Answer -eq "2") {
        DeleteComputers
    } elseif ($Answer -eq "3") {
        ."$PSScriptRoot\..\AD_tools.ps1"
    } else {
        Write-Host "`nThat is not a valid option, choose 1, 2 or 3."
        Options
    }
}

# Call options
Options