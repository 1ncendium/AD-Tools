# Clear the screen
cls

# Information for the host
Write-Host "Started script for listing Active Directory data..."

# Function List users
function ListUsers() {

    # Ask for specific OU
    $Answer = Read-Host -Prompt "Would you like to list users from a specific OU? Y/n"

    if ($Answer -eq "Y") {
    
        # Clear the screen
        cls

        #List OU's
        Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name, DistinguishedName -A
        $OU = Read-Host -Prompt "Select OU DistinguishedName"
        Get-ADUser -Filter * -SearchBase "$OU" | Format-Table Name, ObjectClass, SamAccountName, Enabled
    } else {
        Get-ADUser -Filter *
    }
}

# Function List groups
function ListGroup() {

    # Ask for specific OU
    $Answer = Read-Host -Prompt "Would you like to list groups from a specific OU? Y/n"

    if ($Answer -eq "Y") {
    
        # Clear the screen
        cls

        #List OU's
        Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name, DistinguishedName -A
        $OU = Read-Host -Prompt "Select OU DistinguishedName"
        Get-ADGroup -Filter * -SearchBase "$OU" | Format-Table Name, ObjectClass, SamAccountName, Enabled
    } else {
        Get-ADGroup -Filter *
    }
}

function ListComputers () {

    # Ask for specific OU
    $Answer = Read-Host -Prompt "Would you like to list computers from a specific OU? Y/n"

    if ($Answer -eq "Y") {

        # Clear the screen
        cls

        #List OU's
        Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name, DistinguishedName -A
        $OU = Read-Host -Prompt "Select OU DistinguishedName"
        Get-ADComputer -Filter * -SearchBase "$OU" | Format-Table Name, ObjectClass, SamAccountName, Enabled
    } else {
        Get-ADComputer -Filter *
    }
}

# Show menu
Write-Host "
    1. Users
    2. Groups
    3. Computers
    4. Return
"

function Menu() {
    # Get option
    $Choice = Read-Host "What would you like to do?"

    if ($Choice -eq "1") {
        ListUsers
    } elseif ($Choice -eq "2") {
        ListGroups
    } elseif ($Choice -eq "3") {
        ListComputers
    } elseif ($Choice -eq "4") {
        ."$PSScriptRoot\..\AD_tools.ps1"
    } else {
        Write-Host "That is not a valid option. Choose 1, 2 or 3."
        Menu
    }
}

Menu

# Ask to return to menu
$Return = Read-Host -Prompt "Return to menu? Y/n"

if ($Return -eq "Y") {
    ."$PSScriptRoot\..\AD_tools.ps1"
} else {
    exit
}