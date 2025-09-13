# Prompt the user to press Enter to start the VSCode installation process
Read-Host "Press Enter to start the VSCode installation"

# Ask the user if they want to reinstall VSCode, expecting 'y' or 'n' as valid input
$ReInstallChoice = Read-Host "Do you want to reinstall VSCode? [y/n]"

# Validate the user's input; if invalid, notify and exit
if ($ReInstallChoice -ne "y" -and $ReInstallChoice -ne "n") {
    Write-Output "Please enter 'y' or 'n'"
    Start-Sleep -Seconds 2
    exit
}

# Ask the user if they want to save their VSCode settings before uninstalling
$SaveSettingsChoice = Read-Host "Do you want to save your VSCode settings? [y/n]"

# Validate the input; if invalid, notify and exit
if ($SaveSettingsChoice -ne "y" -and $SaveSettingsChoice -ne "n") {
    Write-Output "Please enter 'y' or 'n'"
    Start-Sleep -Seconds 2
    exit
}

# Define the default installation path for VSCode
$CodePath = "$env:LOCALAPPDATA/Programs/Microsoft VS Code"

# Check if the VSCode executable exists at the default path
$TestFile = Test-Path -Path "$CodePath/Code.exe"

if ($TestFile -eq $false) {
    # If not found, prompt the user to provide the installation folder path
    Write-Host "VSCode is not found in the default location."
    $CodePath = Read-Host "Please enter the path to the folder where VSCode is installed"

    # Verify the executable exists in the provided path
    $TestFile = Test-Path -Path "$CodePath/Code.exe"

    if ($TestFile -eq $false){
        Write-Output "The specified folder does not contain VSCode."
        exit
    }
}
else {
    Write-Output "VSCode is found in the default location."
}

Write-Output "Starting uninstallation of VSCode..."

# Start the uninstallation process silently using the default uninstaller
Start-Process -FilePath "$CodePath/unins000.exe" -ArgumentList "/VERYSILENT" -Wait

Write-Output "Uninstallation of VSCode is complete."

if ($SaveSettingsChoice -eq "y") {
    Write-Output "Saving VSCode settings..."

    # Suppress progress output during file operations
    $ProgressPreference = 'SilentlyContinue'

    # Define the path to the VSCode user settings file and the destination path for backup
    $settingsPath = "$env:APPDATA\Code\User\settings.json"
    $destPath = "$env:USERPROFILE\Downloads\settings.json"

    # If the settings file exists, copy it to the user's Downloads folder
    if (Test-Path $settingsPath) {
        Copy-Item -Path $settingsPath -Destination $destPath -Force
        Write-Output "Settings have been saved to Downloads\settings.json"
    } else {
        Write-Output "No settings.json file found at $settingsPath"
    }
}

# Remove the VSCode folder from APPDATA if it exists
if (Test-Path "$env:APPDATA/Code") {
    Remove-Item -Path "$env:APPDATA/Code" -Recurse -Force
}
else {
    Write-Output "No VSCode folder found in APPDATA at $env:APPDATA"
}

# Remove the .vscode folder from USERPROFILE if it exists
if (Test-Path "$env:USERPROFILE/.vscode") {
    Remove-Item -Path "$env:USERPROFILE/.vscode" -Recurse -Force
    Write-Output "Removed the .vscode folder from USERPROFILE"
}
else {
    Write-Output "No .vscode folder found in USERPROFILE at $env:USERPROFILE"
}

Write-Output "VSCode has been completely uninstalled."

# If the user chose to reinstall, download and install VSCode silently
if ($ReInstallChoice -eq "y") {
    Write-Output "Starting download of VSCode installer..."

    $ProgressPreference = 'SilentlyContinue'

    $installerPath = "$env:TEMP\vscode_installer.exe"

    # Download the latest stable VSCode installer for Windows 64-bit user setup
    Invoke-WebRequest -Uri "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" -OutFile $installerPath

    Write-Output "Download of VSCode installer is complete."

    Write-Output "Starting VSCode installation..."

    # Run the installer silently with specific merge tasks to customize installation
    Start-Process -FilePath $installerPath -ArgumentList '/VERYSILENT', '/mergetasks=!runcode,desktopicon,addcontextmenufiles,addcontextmenufolders,addtopath' -Wait

    Write-Output "Installation of VSCode is complete."

    # Remove the installer file after installation
    Remove-Item -Path $installerPath -Force

    Write-Output "Removed the VSCode installer."
}

Write-Output "Press Enter to close this window."

Read-Host

exit
