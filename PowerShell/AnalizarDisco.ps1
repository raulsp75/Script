function Show-Menu {
    Clear-Host
    Write-Host "=== ANALIZADOR DE DISCO ==="
    Write-Host "1. Mostrar espacio libre en discos"
    Write-Host "2. Listar archivos mayores a 100 MB en una ruta"
    Write-Host "3. Salir"
}

do {
    Show-Menu
    $opcion = Read-Host "Seleccione una opción (1-3)"
    
    switch ($opcion) {
        1 { Get-PSDrive -PSProvider FileSystem | Select-Object Name, Free, Used | Format-Table -AutoSize }
        2 { 
            $ruta = Read-Host "Introduce la ruta a analizar (ej: C:\Users)"
            Get-ChildItem -Path $ruta -Recurse -File | Where-Object { $_.Length -gt 100MB } | 
            Select-Object Name, Directory, Length | Format-Table -AutoSize
        }
        3 { Write-Host "Saliendo..." }
        default { Write-Host "Opción no válida." }
    }
    if ($opcion -ne 3) { Read-Host "Presiona Enter para continuar..." }
} while ($opcion -ne 3)
