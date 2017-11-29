param
(
    $target = "8.8.8.8",
    $retryTime = 30,
    $msg = "Connection error to $target ("+(Get-Date -Format HH:mm)+")",
    $title = "Warning",
    $icon = "None",
    $timeout=1
)
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-null
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | out-null


while ($true) {
    #Test-Connection -ComputerName "Server01" -Count 3 -Delay 2 -TTL 255 -BufferSize 256 -ThrottleLimit 32
    $pinged = Test-Connection -ComputerName $target -Count 1 -Quiet
    # Use an If statement to determine if the machine responded or not and output accordingly
    If ($pinged) 
        { 
            Write-Host "OK" 
        }

    Else { 
        Write-Host "No Reply" 
        $Balloon = new-object System.Windows.Forms.NotifyIcon
        $Balloon.Icon = [System.Drawing.SystemIcons]::Information
        $Balloon.Visible = $true;
        $Balloon.ShowBalloonTip($timeout, $title, $msg, $icon);
    }
    sleep $retryTime
}
