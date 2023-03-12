# Name of software
$softwareName = "Sophos Connect"

# Check if system is 64 or 32bit
$BitVer = ([System.Environment]::Is64BitOperatingSystem)

if ($BitVer){
    # Check if the x64 software is installed
    $Found = (Get-ItemProperty -Path "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" `
        | Where-Object { $_.DisplayName -eq $softwareName })
                
    # Get the software's version number
    $version = (Get-ItemProperty -Path "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" `
        | Where-Object { $_.DisplayName -eq $softwareName }).DisplayVersion
}

else{
    # Check if the x86 software is installed
    $Found = (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" `
        | Where-Object { $_.DisplayName -eq $softwareName })
                
    # Get the software's version number
    $version = (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" `
        | Where-Object { $_.DisplayName -eq $softwareName }).DisplayVersion
}

# Check if software has been upgraded to required version already, proceed with installation if not
if ($version -ne "2.2.90.1104"){

# If Software needs upgrading
if ($Found){
    
    # Check if C:\TE exists 
    $FolderName = "C:\TE\"
    if (Test-Path $FolderName) {
   
        # If true, doesn't create folder
    }
    else
    {
        #Create directory if doesn't exist
        New-Item $FolderName -ItemType Directory
    }

    # Define new program location
    $url = "https://github.com/scopas1293/SophCon/raw/main/SC.msi"
    
    # Define download location
    $output = "C:\TE\SC.msi"
    
    # Download file to destination
    Invoke-WebRequest -Uri $url -OutFile $output
    
    # Delay to allow for download
    Start-Sleep -Seconds 30
    
    # Set arguments for MSIExec: quiet, log verbose to C:\TE\SC_Log.txt
    $installArgs = "/qn /l*v C:\TE\SC_log.txt"
    
    # Install software with arguements (quite, log at C:\TE\)
    Start-Process msiexec.exe -ArgumentList "/i `"$output`" $installArgs" -Wait
}

# If not installed
else {
    Write-Output "$softwareName is not installed"
}
}

# If software has already been upgraded to required version
else {
    Write-Output "$softwareName has already been upgraded to 2.2.90"
}