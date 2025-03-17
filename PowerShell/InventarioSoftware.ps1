function Show-Menu {
    Clear-Host
    Write-Host "=== INVENTARIO DE SOFTWARE ==="
    Write-Host "1. Listar software instalado"
    Write-Host "2. Buscar actualizaciones (Windows Update)"
    Write-Host "3. Salir"
}

do {
    Show-Menu
    $opcion = Read-Host "Seleccione una opción (1-3)"
    
    switch ($opcion) {
        1 { Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Format-Table -AutoSize }
        2 { 
            $updates = Get-WindowsUpdate
            if ($updates) { $updates | Format-Table -AutoSize }
            else { Write-Host "No hay actualizaciones disponibles." }
        }
        3 { Write-Host "Saliendo..." }
        default { Write-Host "Opción no válida." }
    }
    if ($opcion -ne 3) { Read-Host "Presiona Enter para continuar..." }
} while ($opcion -ne 3)
