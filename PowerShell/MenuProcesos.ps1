# Función para mostrar el menú
function Show-Menu {
    Clear-Host
    Write-Host "============================================="
    Write-Host "MENÚ DE GESTIÓN DE PROCESOS"
    Write-Host "============================================="
    Write-Host "1. Mostrar programas que se ejecutan al inicio de sesión"
    Write-Host "2. Guardar un listado de procesos en CSV e imprimir"
    Write-Host "3. Listar y detener procesos con alto consumo de CPU"
    Write-Host "4. Mostrar y detener procesos con más de 100 MB de memoria"
    Write-Host "5. Salir"
    Write-Host "============================================="
}

# Función para mostrar programas que se ejecutan al inicio de sesión
function Show-StartupPrograms {
    Write-Host "Programas que se ejecutan al inicio de sesión:"
    Get-CimInstance -ClassName Win32_StartupCommand | Select-Object Name, Command, Location | Format-Table -AutoSize
}

# Función para guardar un listado de procesos en CSV e imprimir
function Save-ProcessesToCSV {
    $csvPath = "$env:USERPROFILE\Desktop\Procesos.csv"
    Get-Process | Select-Object Name, Id, CPU, WorkingSet | Export-Csv -Path $csvPath -NoTypeInformation
    Write-Host "Listado de procesos guardado en: $csvPath"
    Write-Host "Contenido del archivo CSV:"
    Import-Csv -Path $csvPath | Format-Table -AutoSize
}

# Función para listar y detener procesos con alto consumo de CPU
function Stop-HighCPUProcesses {
    $processes = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
    Write-Host "Procesos con alto consumo de CPU:"
    $processes | Format-Table -AutoSize

    $topProcess = $processes[0]
    Write-Host "Deteniendo el proceso que más consume CPU: $($topProcess.Name) (ID: $($topProcess.Id))"
    Stop-Process -Id $topProcess.Id -Force
}

# Función para mostrar y detener procesos con más de 100 MB de memoria
function Stop-HighMemoryProcesses {
    $processes = Get-Process | Where-Object { $_.WorkingSet -gt 100MB }
    Write-Host "Procesos con más de 100 MB de memoria:"
    $processes | Format-Table -AutoSize

    $processes | ForEach-Object {
        Write-Host "Deteniendo el proceso: $($_.Name) (ID: $($_.Id))"
        Stop-Process -Id $_.Id -Force
    }
}

# Bucle principal del menú
do {
    Show-Menu
    $option = Read-Host "Selecciona una opción (1-5)"

    switch ($option) {
        1 { Show-StartupPrograms }
        2 { Save-ProcessesToCSV }
        3 { Stop-HighCPUProcesses }
        4 { Stop-HighMemoryProcesses }
        5 { Write-Host "Saliendo del menú..." }
        default { Write-Host "Opción no válida. Inténtalo de nuevo." }
    }

    if ($option -ne 5) {
        Read-Host "Presiona Enter para continuar..."
    }
} while ($option -ne 5)
