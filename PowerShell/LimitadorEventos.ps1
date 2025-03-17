
﻿function Show-Menu {
    Clear-Host
    Write-Host "=== LIMPIADOR DE EVENTOS ==="
    Write-Host "1. Limpiar registro de Aplicación"
    Write-Host "2. Limpiar registro de Sistema"
    Write-Host "3. Limpiar todos los registros"
    Write-Host "4. Salir"
}

do {
    Show-Menu
    $opcion = Read-Host "Seleccione una opción (1-4)"
    
    switch ($opcion) {
        1 { Clear-EventLog -LogName "Application"; Write-Host "Registro de Aplicación limpiado." }
        2 { Clear-EventLog -LogName "System"; Write-Host "Registro de Sistema limpiado." }
        3 { Clear-EventLog -LogName *; Write-Host "Todos los registros limpiados." }
        4 { Write-Host "Saliendo..." }
        default { Write-Host "Opción no válida." }
    }
    if ($opcion -ne 4) { Read-Host "Presiona Enter para continuar..." }
} while ($opcion -ne 4)
