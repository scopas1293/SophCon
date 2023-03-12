#Script written by Tech Eagles (Bristol, TN | Panama City, FL)

#Author: Shaun Copas

#Purpose: To upgrade Sophos Connect clients to version 2.2.90.1104 (v2.2 MR1)per Sophos suggestion. Older clients contain known vulnerabilities.

#For OS: Windows x64 and x86

#Known vulnerabilities in older clients: CVE-2022-48309, CVE-2022-48310, CVE-4901

#Sophos Connect Upgrade Powershell Script to version 2.2.90.1104 for Windows Installations

#This software checks to see if Sophos Connect is installed and what version

#Checks if installed version is 2.2.90.1104 and if so sends message of already upgraded

#If Sophos Connect version is not 2.2.90.1104 it proceeds to create a folder, download installation file, silently install, logs to created folder

#Checks for a temporary folder and creates if doesn't exist (C:\TE)

#If not installed writes message "Not Installed"
