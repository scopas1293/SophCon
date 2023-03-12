# Name of software to search for
$softwareName = "Sophos Connect"

# Check if environment is 64bit or 32bit
$BitVer = ([System.Environment]::Is64BitOperatingSystem)

#x64
if ($BitVer){
    # Check if the x64 software is installed
    $Found = (Get-ItemProperty -Path "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" `
        | Where-Object { $_.DisplayName -eq $softwareName })
                
    # Get the software's version number
    if ($Found){
        $version = (Get-ItemProperty -Path "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" `
            | Where-Object { $_.DisplayName -eq $softwareName }).DisplayVersion
    }
}

#x86
else{
    # Check if the x86 software is installed
    $Found = (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" `
        | Where-Object { $_.DisplayName -eq $softwareName })
                
    # Get the software's version number
    if ($Found){
        $version = (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" `
            | Where-Object { $_.DisplayName -eq $softwareName }).DisplayVersion
    }
}

# If software is installed on system
if ($Found){

    # Check if software has been upgraded to required version already, proceed with installation if not
    if ($version -ne "2.2.90.1104"){
    
        # Check if C:\TE exists (Temporary Folder Can be deleted after installation)
        $FolderName = "C:\TE\"
        if (Test-Path $FolderName) {
   
            # If folder already exists, doesn't create folder
        }
        else
        {
            #Create directory if doesn't exist
            New-Item $FolderName -ItemType Directory
        }

        # Define new software install file location
        $url = "https://github.com/scopas1293/SophCon/raw/main/SC.msi"
    
        # Define download destination
        $output = "C:\TE\SC.msi"
    
        # Download file to destination
        Invoke-WebRequest -Uri $url -OutFile $output
    
        # Delay to allow for download
        Start-Sleep -Seconds 30
    
        # Set arguments for MSIExec: normal, quiet, log verbose to C:\TE\SC_Log.txt
        $installArgs = "/qn /l*v C:\TE\SC_log.txt"
    
        # Install software with arguements (normal, quite, log at C:\TE\)
        Start-Process msiexec.exe -ArgumentList "/i `"$output`" $installArgs" -Wait
        }

    # If software has already been upgraded to required version
    else {
        Write-Output "$softwareName has already been upgraded to 2.2.90.1104"
    }
}

# If software is not installed on system
else {
    Write-Output "$softwareName is not installed"
}
