# Clear the screen
cls

# Import required modules
Import-Module ActiveDirectory

# Information for the host
Write-Host "Started script for bulk users..."

# Function add users
function AddUsers() {
    # Promt user for CSV file
    $filepath = Read-Host -Prompt "`nPlease enter your CSV file"

    if (Test-Path $filepath -PathType leaf) {
        echo "`nFile found !"
    } else {
        Write-Host "File not found.. try again"
        AddUsers
    }

    # Import the file into a variable
    $users = Import-Csv $filepath

    # Create a new password
    $securePassword = ConvertTo-SecureString "Passw0rd!4521" -AsPlainText -Force

    # Loop trough each row and gather user data
    ForEach ($user in $users) {
    
        # Gather the user's information
        $fname = $user.'First Name'
        $lname = $user.'Last Name'
        $jtitle = $user.'Job Title'
        $phone = $user.'Office Phone'
        $email = $user.'Email Address'
        $OUpath = $user.'Organizational Unit'

        # Create new AD user
        New-ADUser -Name "$fname $lname" -GivenName $fname -Surname $lname -UserPrincipalName "$fname.$lname" -Path $OUpath -AccountPassword $securePassword -ChangePasswordAtLogon $True -OfficePhone $phone -EmailAddress $email -Enabled $True

        # Echo created user
        echo "Account created for $fname $lname in $OUpath"
    }
}

# Function Disable users
function DisableUsers() {
    # Promt user for txt file
    $file = Read-Host -Prompt "`nPlease enter your TXT file"

    if (Test-Path $file -PathType leaf) {
        echo "`nFile found !"
    } else {
        Write-Host "File not found.. try again"
        DisableUsers
    }   

    # Import the file into a variable
    $users = Get-Content -Path $file

    # Loop trough each row and disable each account
    ForEach ($user in $users) {
        Disable-ADAccount $user

        echo "Disabled account $user"
    }
}

# Function Delete users
function DeleteUsers() {

    # Warn the user
    Write-Host "Are you sure you want to proceed? Deleting users may cause data loss" -ForegroundColor Red
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
        DeleteUsers
    } 

    # Import the file into a variable
    $users = Get-Content -Path $file

    # Loop trough each row and disable each account
    ForEach ($user in $users) {
        Remove-ADUser $user -Confirm:$false

        echo "Deleted account $user"
    }
}

# Function Menu
function Menu() {
    Write-Host "
    `nOptions :
    
    1. Bulk add users
    2. Bulk disable users
    3. Bulk delete users
    4. Return    
    "
}

# Call menu
Menu

function Options() {
    # Promt user for option
    $Answer = Read-Host -Prompt "What would you like to do?"

    if ($Answer -eq "1") {
        AddUsers
    } elseif ($Answer -eq "2") {
        DisableUsers
    } elseif ($Answer -eq "3") {
        DeleteUsers
    } elseif ($Answer -eq "4") {
        ."$PSScriptRoot\..\AD_tools.ps1"
    } else {
        Write-Host "`nThat is not a valid option, choose 1, 2 or 3."
        Options
    }
}

# Call options
Options