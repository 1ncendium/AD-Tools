# Clear screen
cls

# bulk users
function B_users() {
    # Clear screen
    cls

    # Information
    Write-Host "=== Helping with bulk users ===" -ForegroundColor DarkGreen

    # Main
    Write-Host "`nMain" -ForeGroundColor DarkGreen
    Write-Host "`nWith this tool, you can easily :
        - Add users
        - Disable users
        - Delete users
    "

    Write-Host "Adding users" -ForeGroundColor DarkGreen
    Write-Host "
    Type the path to your csv file in the prompt of PowerShell
        Example : c:\scripts\templates\bulk_users_csv
    "

    Write-Host "Disabling / deleting users" -ForeGroundColor DarkGreen
    Write-Host "
    Type the path to your txt file in the prompt of PowerShell
        Example : c:\scripts\templates\disableusers.txt
    "
    Write-Host "Creating a CSV document" -ForegroundColor DarkGreen
    Write-Host "
    To create your own CSV file from an excel sheed, I recommend you to watch this video:
        - https://www.youtube.com/watch?v=z5Pxil4jVO4
    "
    Write-Host "Note : CSV files need to be in the same format as the script, else you need to change the script aswell as the CSV file!" -ForeGroundColor red
}

# Bulk groups
function B_groups() {
    # Clear screen
    cls

    # Information
    Write-Host "=== Helping with bulk groups ===" -ForegroundColor DarkGreen

    # Main
    Write-Host "`nMain" -ForeGroundColor DarkGreen
    Write-Host "`nWith this tool, you can easily :
        - Add groups
        - Delete groups
    "

    Write-Host "Adding groups" -ForeGroundColor DarkGreen
    Write-Host "
    Type the path to your CSV file in the prompt of PowerShell
        Example : c:\scripts\templates\bulk_groups_csv
    "

    Write-Host "Deleting groups" -ForeGroundColor DarkGreen
    Write-Host "
    Type the path to your txt file in the prompt of PowerShell
        Example : c:\scripts\templates\users.txt
    "
    Write-Host "Creating a CSV document" -ForegroundColor DarkGreen
    Write-Host "
    To create your own CSV file from an excel sheed, I recommend you to watch this video:
        - https://www.youtube.com/watch?v=z5Pxil4jVO4
    "
    Write-Host "Note : CSV files need to be in the same format as the script, else you need to change the script aswell as the CSV file!" -ForeGroundColor red
}

# Bulk computers
function B_computers() {
    # Clear screen
    cls

    # Information
    Write-Host "=== Helping with bulk computers ===" -ForegroundColor DarkGreen

    # Main
    Write-Host "`nMain" -ForeGroundColor DarkGreen
    Write-Host "`nWith this tool, you can easily :
        - Add computers
        - Delete computers
    "

    Write-Host "Adding computers" -ForeGroundColor DarkGreen
    Write-Host "
    Type the path to your CSV file in the prompt of PowerShell
        Example : c:\scripts\templates\bulk_computers_csv
    "

    Write-Host "Deleting computers" -ForeGroundColor DarkGreen
    Write-Host "
    Type the path to your txt file in the prompt of PowerShell
        Example : c:\scripts\templates\computers.txt
    "
    Write-Host "Creating a CSV document" -ForegroundColor DarkGreen
    Write-Host "
    To create your own CSV file from an excel sheed, I recommend you to watch this video:
        - https://www.youtube.com/watch?v=z5Pxil4jVO4
    "
    Write-Host "Note : CSV files need to be in the same format as the script, else you need to change the script aswell as the CSV file!" -ForeGroundColor red
}

# List Users, Groups, Computers
function List_UGC() {
    Write-Host "=== Helping with listing Users, Groups or Computers ===" -ForegroundColor DarkGreen

    # Main
    Write-Host "`nMain" -ForeGroundColor DarkGreen
    Write-Host "`nWith this tool, you can easily :
        - List Users (Can list from a specific OU)
        - List Groups (Can list from a specific OU)
        - List Computers (Can list from a specific OU)
    "
    Write-Host "Listing users" -ForeGroundColor DarkGreen
    Write-Host "
    If you choose to list users from a specifc Organizational Unit (OU) then you select 'Y'.
    A list with all the OU's from the current Domain Controller will show up.
    Type / copy the DistinguishedName of the OU into the prompt. The name of the OU wont work.
    "
}

# List domain controllers
function List_DC() {
    Write-Host "=== Helping with listing Domain Controllers ===" -ForegroundColor DarkGreen

    # Main
    Write-Host "`nMain" -ForeGroundColor DarkGreen
    Write-Host "`nWith this tool, you can easily :
        - List Domain Controllers (Can list from a specific domain within a forest)
    "
    Write-Host "Listing Domain Controllers" -ForeGroundColor DarkGreen
    Write-Host "
    If you choose to list Domain controllers from a specifc domain within the forest then you select 'Y'.
    A list with all the domains from the forest will show up.
    Type / copy the name of the domain into the prompt.
    "
}

# Help menu
function Menu() {
    Write-Host "
    `nHelp options :
    
    1. Bulk users
    2. Bulk groups
    3. Bulk computers
    4. Listing users, groups or computers   
    5. Listing Domain Controllers
    6. Return to main menu 
    "
}

# Call menu
Menu

function Help() {
    # Ask the user how we can help
    $HelpOption = Read-Host "How can I help you?"
    
    if ($HelpOption -eq "1") {
        B_users
    } elseif ($HelpOption -eq "2") {
        B_groups
    } elseif ($HelpOption -eq "3") {
        B_computers
    } elseif ($HelpOption -eq "4") {
        List_UGC
    } elseif ($HelpOption -eq "5") {
        List_DC
    } elseif ($HelpOption -eq "6") {
        ."$PSScriptRoot\..\AD_tools.ps1"
    } else {
        Write-Host "That is not a valid option.."
        Help
    }
}

# Call the help function
Help

# Ask to return to menu
$Return = Read-Host -Prompt "Return to help menu? Y/n"

 if ($Return -eq "Y") {
     ."$PSScriptRoot\HelpMenu.ps1"
 } else {
     ."$PSScriptRoot\..\AD_tools.ps1"
 }