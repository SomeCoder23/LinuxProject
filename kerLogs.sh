#!/bin/bash

#go to the file's folder
cd ~/LinuxProject

#generate file name in required format
curDate=$(date +%Y-%m-%d)
curTime=$(date +%H-%M)
fileName="kernal-logs-${curDate}T${curTime}"
logFile="$fileName.txt"
echo "Logging into $logFile..."

#save kernal logs to txt file
journalctl --since "1 hour ago" > $logFile

#compress txt file using bzip2 algorithm
compressedFile="$fileName.tar.bz2"
tar -cjf "$compressedFile" "$logFile"

echo "Compressed $compressedFile"

echo "Uploading to dropbox folder..."
dbxcli put -v "$compressedFile" "/LinuxProject/$compressedFile"  

echo "Deleting files..."
rm $compressedFile
rm $logFile
