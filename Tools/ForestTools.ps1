# Clear the screen
cls

# Information for user
Write-Host "Starting forest tool.."

function ListDC() {
    # Clear screen
    cls

    # Get option answer
    $Answer = Read-Host -Prompt "Do you want to list DC's from a specific domain? Y/n"

    if ($Answer -eq "Y") {
        # Show available domain(s)
        $GetDomain = (Get-ADForest).Domains
        Write-Host "Domain : $GetDomain"

        # Ask for the specific domain
        $Domain = Read-Host -Prompt "Select domain"
        Get-ADDomainController -Discover -Domain $Domain
    } else {
        Get-ADDomainController
    }
}

# Menu
Write-Host "
Forest tool options :
`n1. List domain controller(s)
2. Return to menu
"
function SelectOption() {
    # Ask for option
    $Option = Read-Host "Select option"

    if ($Option -eq "1") {
        ListDC
    } elseif ($Option -eq "2") {
        ."$PSScriptRoot\..\AD_tools.ps1"
    } else {
        Write-Host "`nThat is not a valid option. Choose 1, 2 or 3."
        SelectOption
    }
}

# Call SelectOption
SelectOption

# Ask to return to menu
$Return = Read-Host -Prompt "Return to menu? Y/n"

if ($Return -eq "Y") {
    ."$PSScriptRoot\..\AD_tools.ps1"
} else {
    exit
}