function Show-Menu {
    Clear-Host
    Write-Host "=== COPIA DE SEGURIDAD ==="
    Write-Host "1. Realizar copia de seguridad"
    Write-Host "2. Ver registro de backups"
    Write-Host "3. Salir"
}

$logPath = "$env:USERPROFILE\Desktop\BackupLog.txt"

do {
    Show-Menu
    $opcion = Read-Host "Seleccione una opción (1-3)"
    
    switch ($opcion) {
        1 { 
            $origen = Read-Host "Ruta de origen (ej: C:\Documentos)"
            $destino = Read-Host "Ruta de destino (ej: D:\Backup)"
            $fecha = Get-Date -Format "yyyyMMdd-HHmmss"
            Compress-Archive -Path $origen -DestinationPath "$destino\Backup_$fecha.zip"
            "Backup realizado el $fecha desde $origen" | Out-File -Append $logPath
            Write-Host "Copia de seguridad completada."
        }
        2 { 
            Get-Content $logPath | ForEach-Object { Write-Host $_ }
        }
        3 { Write-Host "Saliendo..." }
        default { Write-Host "Opción no válida." }
    }
    if ($opcion -ne 3) { Read-Host "Presiona Enter para continuar..." }
} while ($opcion -ne 3)
