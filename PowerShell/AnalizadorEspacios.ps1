# Requiere ejecución como administrador
# Ejecutar: Set-ExecutionPolicy RemoteSigned -Scope Process -Force

function Show-Header {
    Clear-Host
    Write-Host "`n"
    Write-Host "***********************************************" -ForegroundColor Cyan
    Write-Host "*           ANALIZADOR DE ESPACIO EN DISCO     *" -ForegroundColor Cyan
    Write-Host "*           Script creado por PEDRO            *" -ForegroundColor Yellow
    Write-Host "*                Versión 2.0                   *" -ForegroundColor Cyan
    Write-Host "***********************************************" -ForegroundColor Cyan
    Write-Host "`n"
}

function Start-Loading {
    param([string]$Message = "Cargando")
    $loadChars = @('-', '\', '|', '/')
    $job = Start-Job -ScriptBlock {
        while ($true) {
            foreach ($c in $using:loadChars) {
                Write-Host "`r$using:Message $c " -NoNewline -ForegroundColor Yellow
                Start-Sleep -Milliseconds 100
            }
        }
    }
    return $job
}

function Stop-Loading {
    param($job)
    Stop-Job $job -ErrorAction SilentlyContinue
    Remove-Job $job -Force
    Write-Host "`r" + (" " * ($Host.UI.RawUI.WindowSize.Width - 1)) -NoNewline
    Write-Host "`r" -NoNewline
}

function Get-TraditionalApps {
    $job = Start-Loading -Message "Analizando aplicaciones tradicionales"
    $apps = Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*", 
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" |
        Where-Object { $_.InstallLocation } |
        Select-Object DisplayName, InstallLocation, Publisher, EstimatedSize
    
    foreach ($app in $apps) {
        if (Test-Path $app.InstallLocation) {
            $size = (Get-ChildItem $app.InstallLocation -Recurse -ErrorAction SilentlyContinue | 
                    Measure-Object -Property Length -Sum).Sum / 1GB
            $app | Add-Member -NotePropertyName "SizeGB" -NotePropertyValue ([math]::Round($size, 3))
        }
    }
    Stop-Loading $job
    $apps | Sort-Object SizeGB -Descending | 
        Select-Object DisplayName, SizeGB, Publisher, InstallLocation |
        Format-Table -AutoSize
}

function Get-ModernApps {
    $job = Start-Loading -Message "Analizando aplicaciones modernas"
    $result = Get-AppxPackage | ForEach-Object {
        $packagePath = (Get-AppxPackageManifest $_).Package.InstalledLocation
        $size = (Get-ChildItem $packagePath -Recurse -ErrorAction SilentlyContinue | 
                Measure-Object -Property Length -Sum).Sum / 1GB
        $_ | Add-Member -NotePropertyName "SizeGB" -NotePropertyValue ([math]::Round($size, 3))
    } | Sort-Object SizeGB -Descending |
        Select-Object Name, Version, SizeGB
    Stop-Loading $job
    $result | Format-Table -AutoSize
}

function Get-LargeFiles {
    $job = Start-Loading -Message "Buscando archivos grandes"
    $result = Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue -Force |
        Where-Object { $_.PSIsContainer -eq $false } |
        Select-Object FullName, Length, LastAccessTime |
        Sort-Object Length -Descending |
        Select-Object -First 50 |
        ForEach-Object {
            [PSCustomObject]@{
                "Tamaño GB" = [math]::Round($_.Length / 1GB, 3)
                "Ultimo Acceso" = $_.LastAccessTime
                "Archivo" = $_.FullName
            }
        }
    Stop-Loading $job
    $result | Format-Table -AutoSize
}

function Get-LargeFolders {
    $job = Start-Loading -Message "Analizando carpetas grandes"
    $folders = Get-ChildItem -Path C:\ -Directory -ErrorAction SilentlyContinue -Force |
        Where-Object { $_.FullName -notmatch "Windows|Program Files|Users" } |
        Select-Object FullName

    $result = foreach ($folder in $folders) {
        $size = (Get-ChildItem $folder.FullName -Recurse -ErrorAction SilentlyContinue | 
                Measure-Object -Property Length -Sum).Sum / 1GB
        if ($size -gt 0) {
            [PSCustomObject]@{
                "Tamaño GB" = [math]::Round($size, 3)
                "Carpeta" = $folder.FullName
            }
        }
    }
    Stop-Loading $job
    $result | Sort-Object "Tamaño GB" -Descending | Select-Object -First 20 | Format-Table -AutoSize
}

# Menú principal
do {
    Show-Header
    Write-Host " MENU PRINCIPAL `n" -ForegroundColor Green
    Write-Host " 1. Listar aplicaciones instaladas tradicionales" -ForegroundColor Yellow
    Write-Host " 2. Listar aplicaciones modernas (Store)" -ForegroundColor Yellow
    Write-Host " 3. Mostrar archivos más grandes" -ForegroundColor Yellow
    Write-Host " 4. Mostrar carpetas más grandes" -ForegroundColor Yellow
    Write-Host " 5. Salir`n" -ForegroundColor Red
    
    $opcion = Read-Host " Selecciona una opción (1-5)"
    
    switch ($opcion) {
        '1' {
            Show-Header
            Write-Host "=== APLICACIONES TRADICIONALES ===" -ForegroundColor Cyan
            Get-TraditionalApps
            Read-Host "`n Presiona Enter para continuar..."
        }
        '2' {
            Show-Header
            Write-Host "=== APLICACIONES MODERNAS ===" -ForegroundColor Cyan
            Get-ModernApps
            Read-Host "`n Presiona Enter para continuar..."
        }
        '3' {
            Show-Header
            Write-Host "=== ARCHIVOS MAS GRANDES ===" -ForegroundColor Cyan
            Get-LargeFiles
            Read-Host "`n Presiona Enter para continuar..."
        }
        '4' {
            Show-Header
            Write-Host "=== CARPETAS MAS GRANDES ===" -ForegroundColor Cyan
            Get-LargeFolders
            Read-Host "`n Presiona Enter para continuar..."
        }
        '5' {
            Write-Host "`n Gracias por usar el script! Hasta luego!`n" -ForegroundColor Green
            exit
        }
        default {
            Write-Host " Opción no válida. Intenta de nuevo." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($true)
