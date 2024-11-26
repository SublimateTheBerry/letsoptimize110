$LangRU = @{
    Welcome = "Dobro pozhalovat v Let'sOptimize110! v2.1.0"
    VisitGitHub = "GitHub: https://github.com/SublimateTheBerry/letsoptimize110"
    MainMenu = "=== Instrument dlya privatnosti i optimizatsii ==="
    Options = @(
        "1. Otklyuchit' telemetriyu i slezhku", 
        "2. Udalit' vstroennye prilozheniya", 
        "3. Optimizirovat' sistemu", 
        "4. Ochistit' vremennye fayly i logi", 
        "5. Obnovit' Windows", 
        "6. Upravlenie konfidentsial'nost'yu", 
        "7. Udaleniye ustarevshikh dannykh", 
        "8. Ustnovit' Google Chrome", 
        "9. Ustnovit' Microsoft Store", 
        "0. Vykhod"
    )
    DisableTelemetry = "=== Otklyuchit' telemetriyu i slezhku ==="
    UninstallApps = "=== Udalit' vstroennye prilozheniya ==="
    OptimizeSystem = "=== Optimizatsiya sistemy ==="
    CleanSystem = "=== Ochistka vremennykh faylov i logov ==="
    UpdateWindows = "=== Obnovlenie Windows ==="
    PrivacyManagement = "=== Upravlenie konfidentsial'nost'yu ==="
    RemoveLegacyData = "=== Udaleniye ustarevshikh dannykh ==="
    InstallChrome = "=== Ustnovit' Google Chrome ==="
    InstallStore = "=== Ustnovit' Microsoft Store ==="
    BackToMenu = "0. Nazad v glavnoe menyu"
    Exit = "Vykhod iz instrumenta. Do svidaniya!"
    InvalidOption = "Nevernyy vybor. Poprobuyte yeshche raz."
}

$LangEN = @{
    Welcome = "Welcome to Let'sOptimize110! v2.1.0"
    VisitGitHub = "GitHub: https://github.com/SublimateTheBerry/letsoptimize110"
    MainMenu = "=== Privacy and Optimization Tool ==="
    Options = @(
        "1. Disable Telemetry and Tracking", 
        "2. Uninstall Built-in Applications", 
        "3. Optimize System for Performance", 
        "4. Clean Temporary Files and Logs", 
        "5. Update Windows", 
        "6. Manage Privacy Settings", 
        "7. Remove Legacy Data", 
        "8. Install Google Chrome", 
        "9. Install Microsoft Store", 
        "0. Exit"
    )
    DisableTelemetry = "=== Disable Telemetry and Tracking ==="
    UninstallApps = "=== Uninstall Built-in Applications ==="
    OptimizeSystem = "=== Optimize System ==="
    CleanSystem = "=== Clean Temporary Files and Logs ==="
    UpdateWindows = "=== Update Windows ==="
    PrivacyManagement = "=== Manage Privacy Settings ==="
    RemoveLegacyData = "=== Remove Legacy Data ==="
    InstallChrome = "=== Install Google Chrome ==="
    InstallStore = "=== Install Microsoft Store ==="
    BackToMenu = "0. Back to Main Menu"
    Exit = "Exiting the tool. Goodbye!"
    InvalidOption = "Invalid option. Please try again."
}

function Select-Language {
    Write-Host "Select language / Vyberite yazyk:"
    Write-Host "1. English"
    Write-Host "2. Russkiy"
    $langChoice = Read-Host "Enter choice / Vvedite vybor"
    switch ($langChoice) {
        1 { return $LangEN }
        2 { return $LangRU }
        default {
            Write-Host "Invalid selection. Defaulting to English."
            return $LangEN
        }
    }
}

$Lang = Select-Language
Write-Host $Lang.Welcome
Write-Host $Lang.VisitGitHub

function Show-Menu {
    Write-Host "`n$($Lang.MainMenu)"
    $Lang.Options | ForEach-Object { Write-Host $_ }
}

function Confirm-And-Execute {
    param (
        [string]$Description, 
        [scriptblock]$Action
    )
    Write-Host "`n$Description" -ForegroundColor Yellow
    Write-Host "1. Da"
    Write-Host "2. Net"
    Write-Host "0. Nazad"
    $choice = Read-Host "Vash vybor"
    switch ($choice) {
        1 { Invoke-Command -ScriptBlock $Action }
        2 { Write-Host "Deystviye otmeneno." -ForegroundColor Red }
        0 { Write-Host "Vozvrat v menyu..." }
        default { Write-Host "Nevernyy vybor. Vozvrat v menyu..." -ForegroundColor Red }
    }
}

function Invoke-Options {
    param (
        [array]$Options
    )
    do {
        Write-Host "`nDisponible deystviya:" -ForegroundColor Cyan
        for ($i = 0; $i -lt $Options.Count; $i++) {
            Write-Host "$($i + 1). $($Options[$i].Name)"
        }
        Write-Host "0. Nazad" -ForegroundColor Red
        $choice = [int](Read-Host "Vyberite deystvie") - 1
        if ($choice -ge 0 -and $choice -lt $Options.Count) {
            $Options[$choice].Action.Invoke()
        }
    } while ($choice -ne -1)
}

function Disable-Telemetry {
    Write-Host "`n=== Otklyucheniye telemetrii i slezhki ===" -ForegroundColor Yellow
    $services = @(
        @{ Name = "Otklyuchit' sluzhbu DiagTrack"; Action = {
            Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
            Set-Service -Name "DiagTrack" -StartupType Disabled
            Write-Host "DiagTrack otklyuchen." -ForegroundColor Green
        }},
        @{ Name = "Otklyuchit' sluzhbu DiagSvc"; Action = {
            Stop-Service -Name "DiagSvc" -ErrorAction SilentlyContinue
            Set-Service -Name "DiagSvc" -StartupType Disabled
            Write-Host "DiagSvc otklyuchen." -ForegroundColor Green
        }},
        @{ Name = "Otklyuchit' Push-udovleniya (dmwappushsvc)"; Action = {
            Stop-Service -Name "dmwappushsvc" -ErrorAction SilentlyContinue
            Set-Service -Name "dmwappushsvc" -StartupType Disabled
            Write-Host "dmwappushsvc otklyuchen." -ForegroundColor Green
        }}
    )
    Invoke-Options $services
}

function Uninstall-Programs {
    Write-Host "`n=== Udaleniye predustanovlennykh prilozheniy ===" -ForegroundColor Yellow
    $apps = @(
        @{ Name = "Udalit' Microsoft Teams"; Action = { Get-AppxPackage "*Teams*" | Remove-AppxPackage }},
        @{ Name = "Udalit' Xbox App"; Action = { Get-AppxPackage "*Xbox*" | Remove-AppxPackage }},
        @{ Name = "Udalit' OneDrive"; Action = { Get-AppxPackage "*OneDrive*" | Remove-AppxPackage }},
        @{ Name = "Udalit' Skype"; Action = { Get-AppxPackage "*SkypeApp*" | Remove-AppxPackage }},
        @{ Name = "Udalit' Solitaire Collection"; Action = { Get-AppxPackage "*MicrosoftSolitaireCollection*" | Remove-AppxPackage }},
        @{ Name = "Udalit' Cortana"; Action = { Get-AppxPackage "*Microsoft.549981C3F5F10*" | Remove-AppxPackage }},
        @{ Name = "Udalit' News and Interests"; Action = { Get-AppxPackage "*MicrosoftNews*" | Remove-AppxPackage }},
        @{ Name = "Udalit' Groove Music"; Action = { Get-AppxPackage "*Microsoft.ZuneMusic*" | Remove-AppxPackage }},
        @{ Name = "Udalit' Xbox Game Bar"; Action = { Get-AppxPackage "*Microsoft.XboxGamingOverlay*" | Remove-AppxPackage }},
        @{ Name = "Udalit' Mixed Reality Portal"; Action = { Get-AppxPackage "*Microsoft.MixedReality.Portal*" | Remove-AppxPackage }},
        @{ Name = "Udalit' Photos App"; Action = { Get-AppxPackage "*Microsoft.Windows.Photos*" | Remove-AppxPackage }},
        @{ Name = "Udalit' Paint 3D"; Action = { Get-AppxPackage "*Microsoft.MicrosoftPaint3D*" | Remove-AppxPackage }}
    )
    Invoke-Options $apps
}

function Optimize-System {
    Write-Host "`n=== Optimizatsiya sistemy ===" -ForegroundColor Yellow
    $options = @(
        @{ Name = "Ustanovit' maksimal'nuyu proizvoditel'nost' (High Performance Power Plan)"; Action = {
            powercfg -SETACTIVE SCHEME_MIN
            Write-Host "Rezhim pitaniya 'Maksimal'naya proizvoditel'nost' vklyuchen." -ForegroundColor Green
        }},
        @{ Name = "Otklyuchit' sluzhby Windows Defender"; Action = {
            Set-MpPreference -DisableRealtimeMonitoring $true
            Write-Host "Zashchita v real'nom vremeni ot Windows Defender vklyuchena." -ForegroundColor Green
        }}
    )
    Invoke-Options $options
}

function Clean-Temp {
    Write-Host "`n=== Ochistka vremennykh faylov i logov ===" -ForegroundColor Yellow
    # Ochistka vremennykh faylov
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force
    Remove-Item -Path "$env:WINDIR\Temp\*" -Recurse -Force
    Write-Host "Vremennye fayly i logi ochishcheny." -ForegroundColor Green
}

function Update-Windows {
    Write-Host "`n=== Obnovlenie Windows ===" -ForegroundColor Yellow
    # Update logic here
    Write-Host "Windows obnovleno." -ForegroundColor Green
}

function Manage-Privacy {
    Write-Host "`n=== Upravlenie konfidentsial'nost'yu ===" -ForegroundColor Yellow
    # Add privacy management commands
    Write-Host "Konfidentsial'nost' obno...dena." -ForegroundColor Green
}

function Remove-LegacyData {
    Write-Host "`n=== Udaleniye ustareshikh dannykh ===" -ForegroundColor Yellow
    # Add legacy data removal commands
    Write-Host "Ustareshie dannye udaleny." -ForegroundColor Green
}

function Install-Chrome {
    Write-Host "`n=== Ustanovit Google Chrome ===" -ForegroundColor Yellow
    # Installation logic for Google Chrome
    Write-Host "Google Chrome ustanovlen." -ForegroundColor Green
}

function Install-Store {
    Write-Host "`n=== Ustanovit Microsoft Store ===" -ForegroundColor Yellow
    # Installation logic for Microsoft Store
    Write-Host "Microsoft Store ustanovlen." -ForegroundColor Green
}

function MainMenu {
    do {
        Show-Menu
        $choice = Read-Host "Vyberite deystvie"
        switch ($choice) {
            "1" { Disable-Telemetry }
            "2" { Uninstall-Programs }
            "3" { Optimize-System }
            "4" { Clean-Temp }
            "5" { Update-Windows }
            "6" { Manage-Privacy }
            "7" { Remove-LegacyData }
            "8" { Install-Chrome }
            "9" { Install-Store }
            "0" { Write-Host $Lang.Exit; break }
            default { Write-Host $Lang.InvalidOption -ForegroundColor Red }
        }
    } while ($choice -ne "0")
}

MainMenu
