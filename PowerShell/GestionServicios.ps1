function Show-Menu {
    Clear-Host
    Write-Host "=== GESTIÓN DE SERVICIOS ==="
    Write-Host "1. Listar servicios en ejecución"
    Write-Host "2. Detener un servicio"
    Write-Host "3. Iniciar un servicio"
    Write-Host "4. Reiniciar un servicio"
    Write-Host "5. Salir"
}

do {
    Show-Menu
    $opcion = Read-Host "Seleccione una opción (1-5)"
    
    switch ($opcion) {
        1 { Get-Service | Where-Object { $_.Status -eq "Running" } | Format-Table -AutoSize }
        2 { 
            $servicio = Read-Host "Nombre del servicio a detener"
            Stop-Service -Name $servicio -Force
            Write-Host "Servicio $servicio detenido."
        }
        3 { 
            $servicio = Read-Host "Nombre del servicio a iniciar"
            Start-Service -Name $servicio
            Write-Host "Servicio $servicio iniciado."
        }
        4 { 
            $servicio = Read-Host "Nombre del servicio a reiniciar"
            Restart-Service -Name $servicio -Force
            Write-Host "Servicio $servicio reiniciado."
        }
        5 { Write-Host "Saliendo..." }
        default { Write-Host "Opción no válida." }
    }
    if ($opcion -ne 5) { Read-Host "Presiona Enter para continuar..." }
} while ($opcion -ne 5)
