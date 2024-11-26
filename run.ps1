$LangRU = @{
    Welcome = "Добро пожаловать в Let'sOptimize110! v2.0.0"
    VisitGitHub = "GitHub: https://github.com/SublimateTheBerry/letsoptimize110"
    MainMenu = "=== Инструмент для приватности и оптимизации ==="
    Options = @(
        "1. Отключить телеметрию и слежку", 
        "2. Удалить встроенные приложения", 
        "3. Оптимизировать систему", 
        "4. Очистить временные файлы и логи", 
        "5. Обновить Windows", 
        "6. Управление конфиденциальностью", 
        "7. Удаление устаревших данных", 
        "8. Установить Google Chrome", 
        "9. Установить Microsoft Store", 
        "0. Выход"
    )
    DisableTelemetry = "=== Отключить телеметрию и слежку ==="
    UninstallApps = "=== Удалить встроенные приложения ==="
    OptimizeSystem = "=== Оптимизация системы ==="
    CleanSystem = "=== Очистка временных файлов и логов ==="
    UpdateWindows = "=== Обновление Windows ==="
    PrivacyManagement = "=== Управление конфиденциальностью ==="
    RemoveLegacyData = "=== Удаление устаревших данных ==="
    InstallChrome = "=== Установить Google Chrome ==="
    InstallStore = "=== Установить Microsoft Store ==="
    BackToMenu = "0. Назад в главное меню"
    Exit = "Выход из инструмента. До свидания!"
    InvalidOption = "Неверный выбор. Попробуйте еще раз."
}

$LangEN = @{
    Welcome = "Welcome to Let'sOptimize110! v3.0.0"
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
    Write-Host "Select language / Выберите язык:"
    Write-Host "1. English"
    Write-Host "2. Русский"
    $langChoice = Read-Host "Enter choice / Введите выбор"
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
Write-Host $Lang.Welcome -ForegroundColor Cyan
Write-Host $Lang.VisitGitHub -ForegroundColor Green

function Show-Menu {
    Write-Host "`n$($Lang.MainMenu)"
    $Lang.Options | ForEach-Object { Write-Host $_ }
}

# Функция подтверждения с выбором
function Confirm-And-Execute {
    param (
        [string]$Description, 
        [scriptblock]$Action
    )
    Write-Host "`n$Description" -ForegroundColor Yellow
    Write-Host "1. Да"
    Write-Host "2. Нет"
    Write-Host "0. Назад"
    $choice = Read-Host "Ваш выбор"
    switch ($choice) {
        1 { Invoke-Command -ScriptBlock $Action }
        2 { Write-Host "Действие отменено." -ForegroundColor Red }
        0 { Write-Host "Возврат в меню..." }
        default { Write-Host "Неверный выбор. Возврат в меню..." -ForegroundColor Red }
    }
}

# Выбор действий в каждом пункте
function Invoke-Options {
    param (
        [array]$Options
    )
    do {
        Write-Host "`nДоступные действия:" -ForegroundColor Cyan
        for ($i = 0; $i -lt $Options.Count; $i++) {
            Write-Host "$($i + 1). $($Options[$i].Name)"
        }
        Write-Host "0. Назад" -ForegroundColor Red
        $choice = [int](Read-Host "Выберите действие") - 1
        if ($choice -ge 0 -and $choice -lt $Options.Count) {
            $Options[$choice].Action.Invoke()
        }
    } while ($choice -ne -1)
}

# Отключение телеметрии и служб слежки
function Disable-Telemetry {
    Write-Host "`n=== Отключение телеметрии и слежки ===" -ForegroundColor Yellow
    $services = @(
        @{ Name = "Отключить службу Диагностического отслеживания (DiagTrack)"; Action = {
            Stop-Service -Name "DiagTrack" -ErrorAction SilentlyContinue
            Set-Service -Name "DiagTrack" -StartupType Disabled
            Write-Host "DiagTrack отключен." -ForegroundColor Green
        }},
        @{ Name = "Отключить службу Connected User Experiences"; Action = {
            Stop-Service -Name "DiagSvc" -ErrorAction SilentlyContinue
            Set-Service -Name "DiagSvc" -StartupType Disabled
            Write-Host "Connected User Experiences отключен." -ForegroundColor Green
        }},
        @{ Name = "Отключить Push-уведомления (dmwappushsvc)"; Action = {
            Stop-Service -Name "dmwappushsvc" -ErrorAction SilentlyContinue
            Set-Service -Name "dmwappushsvc" -StartupType Disabled
            Write-Host "dmwappushsvc отключен." -ForegroundColor Green
        }}
    )
    Invoke-Options $services
}

# Удаление предустановленных приложений
function Uninstall-Programs {
    Write-Host "`n=== Удаление предустановленных приложений ===" -ForegroundColor Yellow
    $apps = @(
        @{ Name = "Удалить Microsoft Teams"; Action = { Get-AppxPackage "*Teams*" | Remove-AppxPackage }},
        @{ Name = "Удалить Xbox App"; Action = { Get-AppxPackage "*Xbox*" | Remove-AppxPackage }},
        @{ Name = "Удалить OneDrive"; Action = { Get-AppxPackage "*OneDrive*" | Remove-AppxPackage }},
        @{ Name = "Удалить Skype"; Action = { Get-AppxPackage "*SkypeApp*" | Remove-AppxPackage }},
        @{ Name = "Удалить Solitaire Collection"; Action = { Get-AppxPackage "*MicrosoftSolitaireCollection*" | Remove-AppxPackage }},
        @{ Name = "Удалить Cortana"; Action = { Get-AppxPackage "*Microsoft.549981C3F5F10*" | Remove-AppxPackage }},
        @{ Name = "Удалить News and Interests"; Action = { Get-AppxPackage "*MicrosoftNews*" | Remove-AppxPackage }},
        @{ Name = "Удалить Groove Music"; Action = { Get-AppxPackage "*Microsoft.ZuneMusic*" | Remove-AppxPackage }},
        @{ Name = "Удалить Xbox Game Bar"; Action = { Get-AppxPackage "*Microsoft.XboxGamingOverlay*" | Remove-AppxPackage }},
        @{ Name = "Удалить Mixed Reality Portal"; Action = { Get-AppxPackage "*Microsoft.MixedReality.Portal*" | Remove-AppxPackage }},
        @{ Name = "Удалить Photos App"; Action = { Get-AppxPackage "*Microsoft.Windows.Photos*" | Remove-AppxPackage }},
        @{ Name = "Удалить Paint 3D"; Action = { Get-AppxPackage "*Microsoft.MicrosoftPaint3D*" | Remove-AppxPackage }}
    )
    Invoke-Options $apps
}

# Оптимизация системы
function Optimize-System {
    Write-Host "`n=== Оптимизация системы ===" -ForegroundColor Yellow
    $options = @(
        @{ Name = "Установить максимальную производительность (High Performance Power Plan)"; Action = {
            powercfg -SETACTIVE SCHEME_MIN
            Write-Host "Режим питания 'Максимальная производительность' установлен." -ForegroundColor Green
        }},
        @{ Name = "Отключить контроль учетных записей (UAC)"; Action = {
            reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f
            Write-Host "UAC отключен." -ForegroundColor Green
        }}
    )
    Invoke-Options $options
}

# Очистка системы
function Clean-System {
    Write-Host "`n=== Очистка временных файлов и логов ===" -ForegroundColor Yellow
    $cleanOptions = @(
        @{ Name = "Очистить временные файлы Windows"; Action = {
            Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Временные файлы очищены." -ForegroundColor Green
        }},
        @{ Name = "Очистить временные файлы пользователя"; Action = {
            Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Пользовательские временные файлы очищены." -ForegroundColor Green
        }}
    )
    Invoke-Options $cleanOptions
}

# Обновление Windows
function Update-Windows {
    Write-Host "`n=== Обновление Windows ===" -ForegroundColor Yellow
    Confirm-And-Execute "Запустить обновление Windows?" {
        Install-Module PSWindowsUpdate -Force -Scope CurrentUser -ErrorAction SilentlyContinue
        Get-WindowsUpdate -Install -AcceptAll -ErrorAction SilentlyContinue
        Write-Host "Обновления установлены." -ForegroundColor Green
    }
}

# Управление конфиденциальностью
function Manage-Privacy {
    Write-Host "`n=== Управление конфиденциальностью ===" -ForegroundColor Yellow
    $privacyOptions = @(
        @{ Name = "Отключить персонализированную рекламу"; Action = {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0
            Write-Host "Персонализированная реклама отключена." -ForegroundColor Green
        }},
        @{ Name = "Отключить предложения в меню Пуск"; Action = {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0
            Write-Host "Предложения в меню Пуск отключены." -ForegroundColor Green
        }}
    )
    Invoke-Options $privacyOptions
}

# Установка приложений
function Install-GoogleChrome {
    Confirm-And-Execute "Установить Google Chrome с официального сайта?" {
        $url = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
        $output = "$env:TEMP\chrome_installer.exe"
        Invoke-WebRequest -Uri $url -OutFile $output
        Start-Process -FilePath $output -ArgumentList "/silent /install" -Wait
        Remove-Item -Path $output
        Write-Host "Google Chrome установлен." -ForegroundColor Green
    }
}

function Install-MicrosoftStore {
    Confirm-And-Execute "Установить Microsoft Store?" {
        Add-AppxPackage -Path "C:\Program Files\WindowsApps\Microsoft.WindowsStore_*"
        Write-Host "Microsoft Store установлен." -ForegroundColor Green
    }
}

# Главное меню
function Show-Menu {
    Write-Host "`n=== Главное меню ===" -ForegroundColor Cyan
    Write-Host "1. Отключить телеметрию и слежку"
    Write-Host "2. Удалить встроенные приложения"
    Write-Host "3. Оптимизировать систему"
    Write-Host "4. Очистить временные файлы и логи"
    Write-Host "5. Обновить Windows"
    Write-Host "6. Управление конфиденциальностью"
    Write-Host "7. Установить Google Chrome"
    Write-Host "8. Установить Microsoft Store"
    Write-Host "0. Выход"
}

do {
    Show-Menu
    $mainChoice = Read-Host "Выберите опцию"
    switch ($mainChoice) {
        1 { Disable-Telemetry }
        2 { Uninstall-Programs }
        3 { Optimize-System }
        4 { Clean-System }
        5 { Update-Windows }
        6 { Manage-Privacy }
        7 { Install-GoogleChrome }
        8 { Install-MicrosoftStore }
        0 { break }
        default { Write-Host "Неверный выбор." -ForegroundColor Red }
    }
} while ($mainChoice -ne 0)

Write-Host "До свидания!" -ForegroundColor Cyan
