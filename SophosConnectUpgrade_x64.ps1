# Name of software
$softwareName = "Sophos Connect"

# Check if the software is installed
if (Get-ItemProperty -Path "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" `
    | Where-Object { $_.DisplayName -eq $softwareName }) {
      
      # Check if C:\TE exists 
        $FolderName = "C:\TE\"
        if (Test-Path $FolderName) {
   
            # If so don't create folder
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
    
    # Set arguments for MSIExec: quiet, Log to C:\TE\SC_Log.txt
    $installArgs = "/qn /l*v C:\TE\SC_log.txt"
    
    # Install software with arguements (Log at C:\TE\)
    Start-Process msiexec.exe -ArgumentList "/i `"$output`" $installArgs" -Wait
     
}

# If not installed
else {
    Write-Output "$softwareName is not installed"
}