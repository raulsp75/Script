# Script "menu_archivos" - Gestión básica de archivos
function Get-FileMenu {
    Clear-Host
    Write-Host "=== Gestión de Archivos ==="
    Write-Host "1. Listar archivos grandes (>100MB)"
    Write-Host "2. Buscar archivos por extensión"
    Write-Host "3. Crear copia de seguridad"
    Write-Host "4. Limpiar archivos temporales"
    Write-Host "5. Volver al menú principal"
    
    $opcion = Read-Host "Seleccione una opción (1-5)"
    
    switch ($opcion) {
        1 { 
            Get-ChildItem -Path C:\ -Recurse -File |
            Where-Object { $_.Length -gt 100MB } |
            Sort-Object Length -Descending |
            Select-Object FullName, @{N='Size(MB)';E={$_.Length / 1MB}}
        }
        2 {
            $ext = Read-Host "Extensión a buscar (sin punto)"
            Get-ChildItem -Path C:\ -Recurse -File -Filter "*.$ext"
        }
        3 {
            $origen = Read-Host "Directorio a respaldar"
            $destino = "C:\Backups\$(Get-Date -Format 'yyyy-MM-dd')"
            Copy-Item -Path $origen -Destination $destino -Recurse
            Write-Host "Backup creado en $destino"
        }
        4 {
            Remove-Item -Path $env:TEMP\* -Recurse -Force
            Write-Host "Archivos temporales eliminados"
        }
        5 { return }
        default { Write-Host "Opción no válida" }
    }
    Pause
}

# Script "monitor_sistema" - Monitorización del sistema
function Get-SystemMonitor {
    Clear-Host
    Write-Host "=== Monitor del Sistema ==="
    Write-Host "1. CPU más utilizados"
    Write-Host "2. Memoria más utilizada"
    Write-Host "3. Espacio en disco"
    Write-Host "4. Servicios detenidos"
    Write-Host "5. Volver al menú principal"
    
    $opcion = Read-Host "Seleccione una opción (1-5)"
    
    switch ($opcion) {
        1 { 
            Get-Process | Sort-Object CPU -Descending | 
            Select-Object -First 5 Name, CPU, WorkingSet 
        }
        2 { 
            Get-Process | Sort-Object WS -Descending | 
            Select-Object -First 5 Name, WS, CPU 
        }
        3 { Get-PSDrive -PSProvider FileSystem }
        4 { Get-Service | Where-Object Status -eq 'Stopped' }
        5 { return }
        default { Write-Host "Opción no válida" }
    }
    Pause
}

# Script "gestor_redes" - Gestión de redes
function Get-NetworkManager {
    Clear-Host
    Write-Host "=== Gestión de Redes ==="
    Write-Host "1. Ver configuración IP"
    Write-Host "2. Probar conexión"
    Write-Host "3. Ver puertos activos"
    Write-Host "4. Estado del adaptador"
    Write-Host "5. Volver al menú principal"
    
    $opcion = Read-Host "Seleccione una opción (1-5)"
    
    switch ($opcion) {
        1 { ipconfig /all }
        2 {
            $destino = Read-Host "Introduce IP o dominio"
            Test-Connection $destino -Count 4
        }
        3 { Get-NetTCPConnection | Where-Object State -eq 'Established' }
        4 { Get-NetAdapter | Format-Table Name, Status, LinkSpeed }
        5 { return }
        default { Write-Host "Opción no válida" }
    }
    Pause
}

# Script "info_hardware" - Información del hardware
function Get-HardwareInfo {
    Clear-Host
    Write-Host "=== Información de Hardware ==="
    Write-Host "1. Información del procesador"
    Write-Host "2. Información de memoria"
    Write-Host "3. Información de disco"
    Write-Host "4. Información de BIOS"
    Write-Host "5. Volver al menú principal"
    
    $opcion = Read-Host "Seleccione una opción (1-5)"
    
    switch ($opcion) {
        1 { Get-WmiObject Win32_Processor | Format-List Name, MaxClockSpeed, NumberOfCores }
        2 { Get-WmiObject Win32_PhysicalMemory | Format-Table Capacity, Speed, Manufacturer }
        3 { Get-WmiObject Win32_LogicalDisk | Format-Table DeviceID, Size, FreeSpace }
        4 { Get-WmiObject Win32_BIOS | Format-List Manufacturer, Version, ReleaseDate }
        5 { return }
        default { Write-Host "Opción no válida" }
    }
    Pause
}

# Script "gestor_usuarios" - Gestión de usuarios
function Get-UserManager {
    Clear-Host
    Write-Host "=== Gestión de Usuarios ==="
    Write-Host "1. Listar usuarios"
    Write-Host "2. Crear usuario"
    Write-Host "3. Eliminar usuario"
    Write-Host "4. Cambiar contraseña"
    Write-Host "5. Volver al menú principal"
    
    $opcion = Read-Host "Seleccione una opción (1-5)"
    
    switch ($opcion) {
        1 { Get-LocalUser | Format-Table Name, Enabled, LastLogon }
        2 { 
            $nombre = Read-Host "Nombre de usuario"
            $pass = Read-Host "Contraseña" -AsSecureString
            New-LocalUser -Name $nombre -Password $pass
            Write-Host "Usuario creado exitosamente"
        }
        3 {
            $nombre = Read-Host "Nombre de usuario a eliminar"
            Remove-LocalUser -Name $nombre
            Write-Host "Usuario eliminado"
        }
        4 {
            $nombre = Read-Host "Nombre de usuario"
            $pass = Read-Host "Nueva contraseña" -AsSecureString
            Set-LocalUser -Name $nombre -Password $pass
            Write-Host "Contraseña actualizada"
        }
        5 { return }
        default { Write-Host "Opción no válida" }
    }
    Pause
}

# Script "gestor_servicios" - Gestión de servicios
function Get-ServiceManager {
    Clear-Host
    Write-Host "=== Gestión de Servicios ==="
    Write-Host "1. Listar servicios en ejecución"
    Write-Host "2. Iniciar servicio"
    Write-Host "3. Detener servicio"
    Write-Host "4. Reiniciar servicio"
    Write-Host "5. Volver al menú principal"
    
    $opcion = Read-Host "Seleccione una opción (1-5)"
    
    switch ($opcion) {
        1 { Get-Service | Where-Object Status -eq 'Running' }
        2 {
            $nombre = Read-Host "Nombre del servicio"
            Start-Service -Name $nombre
            Write-Host "Servicio iniciado"
        }
        3 {
            $nombre = Read-Host "Nombre del servicio"
            Stop-Service -Name $nombre
            Write-Host "Servicio detenido"
        }
        4 {
            $nombre = Read-Host "Nombre del servicio"
            Restart-Service -Name $nombre
            Write-Host "Servicio reiniciado"
        }
        5 { return }
        default { Write-Host "Opción no válida" }
    }
    Pause
}

# Menú Principal
function Show-MainMenu {
    do {
        Clear-Host
        Write-Host "=== MENÚ PRINCIPAL ==="
        Write-Host "1. Gestión de Archivos"
        Write-Host "2. Monitor del Sistema"
        Write-Host "3. Gestión de Redes"
        Write-Host "4. Información de Hardware"
        Write-Host "5. Gestión de Usuarios"
        Write-Host "6. Gestión de Servicios"
        Write-Host "7. Salir"
        
        $opcion = Read-Host "Seleccione una opción (1-7)"
        
        switch ($opcion) {
            1 { Get-FileMenu }
            2 { Get-SystemMonitor }
            3 { Get-NetworkManager }
            4 { Get-HardwareInfo }
            5 { Get-UserManager }
            6 { Get-ServiceManager }
            7 { 
                Clear-Host
                Write-Host "¡Hasta luego!"
                return 
            }
            default { 
                Write-Host "Opción no válida"
                Start-Sleep -Seconds 2
            }
        }
    } while ($true)
}

# Iniciar el script
Show-MainMenu
