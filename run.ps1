Write-Host "Welcome to Let'sOptimize110!" -ForegroundColor Cyan
Write-Host "Visit us on GitHub: https://github.com/SublimateTheBerry/letsoptimize110" -ForegroundColor Green

function Show-Menu {
    Write-Host "`n=== Privacy and Optimization Tool ===" -ForegroundColor Cyan
    Write-Host "1. Disable Telemetry"
    Write-Host "2. Uninstall Programs"
    Write-Host "3. Optimize System"
    Write-Host "0. Exit" -ForegroundColor Red
}

function Disable-Telemetry {
    Write-Host "`n=== Disable Telemetry ===" -ForegroundColor Yellow
    Write-Host "1. Disable Diagnostic Tracking Service (Tracks usage)"
    Write-Host "2. Disable Connected User Experiences (Collects data for feedback)"
    Write-Host "3. Disable Compatibility Telemetry (Analyzes compatibility issues)"
    Write-Host "4. Disable Windows Error Reporting (Sends crash data)"
    Write-Host "0. Back to Main Menu" -ForegroundColor Red
    $choice = Read-Host "Select an option"

    switch ($choice) {
        1 {
            Write-Host "Disabling Diagnostic Tracking Service..."
            Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
            Set-Service -Name "DiagTrack" -StartupType Disabled
            Write-Host "Diagnostic Tracking Service disabled." -ForegroundColor Green
        }
        2 {
            Write-Host "Disabling Connected User Experiences..."
            Stop-Service -Name "DiagSvc" -ErrorAction SilentlyContinue
            Set-Service -Name "DiagSvc" -StartupType Disabled
            Write-Host "Connected User Experiences disabled." -ForegroundColor Green
        }
        3 {
            Write-Host "Disabling Compatibility Telemetry..."
            reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
            Write-Host "Compatibility Telemetry disabled." -ForegroundColor Green
        }
        4 {
            Write-Host "Disabling Windows Error Reporting..."
            reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
            Write-Host "Windows Error Reporting disabled." -ForegroundColor Green
        }
        0 { return }
        default { Write-Host "Invalid option. Please try again." -ForegroundColor Red }
    }
}

function Uninstall-Programs {
    Write-Host "`n=== Uninstall Programs ===" -ForegroundColor Yellow
    Write-Host "1. Uninstall Microsoft Teams"
    Write-Host "2. Uninstall Microsoft 365 Apps"
    Write-Host "3. Uninstall Xbox App"
    Write-Host "4. Uninstall OneDrive"
    Write-Host "5. Uninstall Skype"
    Write-Host "6. Uninstall Cortana"
    Write-Host "7. Uninstall Windows Store"
    Write-Host "8. Uninstall Groove Music"
    Write-Host "9. Uninstall Photos App"
    Write-Host "10. Uninstall Mail and Calendar"
    Write-Host "11. Uninstall Microsoft News"
    Write-Host "12. Uninstall Xbox Game Bar"
    Write-Host "13. Uninstall Feedback Hub"
    Write-Host "14. Uninstall Weather App"
    Write-Host "0. Back to Main Menu" -ForegroundColor Red
    $choice = Read-Host "Select an option"

    switch ($choice) {
        1 {
            Write-Host "Uninstalling Microsoft Teams..."
            Get-AppxPackage -Name "MicrosoftTeams" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Microsoft Teams uninstalled." -ForegroundColor Green
        }
        2 {
            Write-Host "Uninstalling Microsoft 365 Apps..."
            Get-AppxPackage -Name "*Office*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Microsoft 365 Apps uninstalled." -ForegroundColor Green
        }
        3 {
            Write-Host "Uninstalling Xbox App..."
            Get-AppxPackage -Name "*Xbox*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Xbox App uninstalled." -ForegroundColor Green
        }
        4 {
            Write-Host "Uninstalling OneDrive..."
            Start-Process "C:\Windows\SysWOW64\OneDriveSetup.exe" "/uninstall" -NoNewWindow -Wait
            Write-Host "OneDrive uninstalled." -ForegroundColor Green
        }
        5 {
            Write-Host "Uninstalling Skype..."
            Get-AppxPackage -Name "*Skype*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Skype uninstalled." -ForegroundColor Green
        }
        6 {
            Write-Host "Uninstalling Cortana..."
            Get-AppxPackage -Name "*Cortana*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Cortana uninstalled." -ForegroundColor Green
        }
        7 {
            Write-Host "Uninstalling Windows Store..."
            Get-AppxPackage -Name "*WindowsStore*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Windows Store uninstalled." -ForegroundColor Green
        }
        8 {
            Write-Host "Uninstalling Groove Music..."
            Get-AppxPackage -Name "*ZuneMusic*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Groove Music uninstalled." -ForegroundColor Green
        }
        9 {
            Write-Host "Uninstalling Photos App..."
            Get-AppxPackage -Name "*Microsoft.Windows.Photos*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Photos App uninstalled." -ForegroundColor Green
        }
        10 {
            Write-Host "Uninstalling Mail and Calendar..."
            Get-AppxPackage -Name "*Microsoft.windowscommunicationsapps*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Mail and Calendar uninstalled." -ForegroundColor Green
        }
        11 {
            Write-Host "Uninstalling Microsoft News..."
            Get-AppxPackage -Name "*Microsoft.BingNews*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Microsoft News uninstalled." -ForegroundColor Green
        }
        12 {
            Write-Host "Uninstalling Xbox Game Bar..."
            Get-AppxPackage -Name "*Microsoft.XboxGamingOverlay*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Xbox Game Bar uninstalled." -ForegroundColor Green
        }
        13 {
            Write-Host "Uninstalling Feedback Hub..."
            Get-AppxPackage -Name "*Microsoft.WindowsFeedbackHub*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Feedback Hub uninstalled." -ForegroundColor Green
        }
        14 {
            Write-Host "Uninstalling Weather App..."
            Get-AppxPackage -Name "*Microsoft.BingWeather*" | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host "Weather App uninstalled." -ForegroundColor Green
        }
        0 { return }
        default { Write-Host "Invalid option. Please try again." -ForegroundColor Red }
    }
}

function Optimize-System {
    Write-Host "`n=== Optimize System ===" -ForegroundColor Yellow
    Write-Host "1. Disable Startup Items"
    Write-Host "2. Disable Unused Services (e.g., Bluetooth)"
    Write-Host "3. Disable Visual Effects for Performance"
    Write-Host "0. Back to Main Menu" -ForegroundColor Red
    $choice = Read-Host "Select an option"

    switch ($choice) {
        1 {
            Write-Host "Disabling startup items..."
            Get-CimInstance Win32_StartupCommand | Foreach-Object {
                Write-Host "Disabling $($_.Name)..."
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "$($_.Name)" /t REG_SZ /d "" /f
            }
            Write-Host "Startup items disabled." -ForegroundColor Green
        }
        2 {
            Write-Host "Disabling unused services..."
            Set-Service -Name "bthserv" -StartupType Disabled
            Write-Host "Bluetooth Service disabled." -ForegroundColor Green
        }
        3 {
            Write-Host "Disabling visual effects..."
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
            Write-Host "Visual effects disabled for better performance." -ForegroundColor Green
        }
        0 { return }
        default { Write-Host "Invalid option. Please try again." -ForegroundColor Red }
    }
}

do {
    Show-Menu
    $mainChoice = Read-Host "Select an option"
    switch ($mainChoice) {
        1 { Disable-Telemetry }
        2 { Uninstall-Programs }
        3 { Optimize-System }
        0 { break }
        default { Write-Host "Invalid option. Please try again." -ForegroundColor Red }
    }
} while ($mainChoice -ne 0)

Write-Host "`nExiting the tool. Goodbye!" -ForegroundColor Cyan
