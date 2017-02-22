$IISLogPath = "D:\Log\IIS\W3SVC15\u_ex170221.log" 
$IISLogFileRaw = [System.IO.File]::ReadAllLines($IISLogPath)
$headers = $IISLogFileRaw[3].split(" ")
$headers = $headers | where {$_ -ne "#Fields:"}
Get-Content $IISLogPath | select -Skip 4| ConvertFrom-Csv -Delimiter " " -Header  $headers | where{ [convert]::ToInt32($_."time-taken",10) -gt 5000 }
