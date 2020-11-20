# Clear the screen
cls

# Information for the host
Write-Host "Started script for bulk groups..."

# Import required modules
Import-Module ActiveDirectory

function AddGroups() {
    # Promt user for CSV file
    $filepath = Read-Host -Prompt "`nPlease enter your CSV file"

    # Check if filepath exists..
    if (Test-Path $filepath -PathType leaf) {
        echo "`nFile found !"
    } else {
        Write-Host "File not found.. try again"
        AddGroups
    }

    # Import the file into a variable
    $groups = Import-Csv $filepath

    # Loop trough each row and gather group data
    ForEach ($group in $groups) {
    
        # Gather the group's information
        $gname = $group.'Group name'
        $gscope = $group.'Group Scope'
        $gtype = $group.'Group Type'
        $gdescr = $group.Description
        $OUpath = $group.'Organizational Unit'

         # Create new AD group
         New-ADGroup -Name $gname -GroupScope Global -GroupCategory Security -Description $gdescr -Path $OUpath

         # Echo created group
         echo "Group $gname created in $OUpath"
    }
}

function DeleteGroups() {
    
    # Warn the user
    Write-Host "Are you sure you want to proceed? Deleting groups may cause data loss" -ForegroundColor Red
    $Continue = Read-Host -Prompt "Continue Y/n"

    if ($Continue -eq "Y")
        {cls}
    else {
        ."$PSScriptRoot\..\AD_tools.ps1"
    }

    # Promt user for txt file
    $file = Read-Host -Prompt "`nPlease enter your TXT file"

    # Check if file exists..
    if (Test-Path $file -PathType leaf) {
        echo "`nFile found !"
    } else {
        Write-Host "File not found.. try again"
        DeleteGroups
    }

    # Import the file into a variable
    $groups = Get-Content -Path $file

    # Loop trough each row and disable each account
    ForEach ($group in $groups) {
        Remove-ADGroup $group -Confirm:$false

        echo "Deleted group $group"
    }
}

# Function Menu
function Menu() {
    Write-Host "
    Options :
    
    1. Bulk add groups
    2. Bulk delete groups
    3. Return    
    "
}

# Call menu
Menu

function Options() {
    # Promt user for option
    $Answer = Read-Host -Prompt "What would you like to do?"

    if ($Answer -eq "1") {
        AddGroups
    } elseif ($Answer -eq "2") {
        DeleteGroups
    } elseif ($Answer -eq "3") {
        ."$PSScriptRoot\..\AD_tools.ps1"
    } else {
        Write-Host "`nThat is not a valid option, choose 1, 2 or 3."
        Options
    }
}

# Call options
Options

# Ask to return to menu
$Return = Read-Host -Prompt "Return to menu? Y/n"

if ($Return -eq "Y") {
    ."$PSScriptRoot\..\AD_tools.ps1"
} else {
    exit
}