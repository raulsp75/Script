function Show-Menu {
    Clear-Host
    Write-Host "=== GESTOR DE FIREWALL ==="
    Write-Host "1. Listar reglas activas"
    Write-Host "2. Habilitar una regla"
    Write-Host "3. Deshabilitar una regla"
    Write-Host "4. Salir"
}

do {
    Show-Menu
    $opcion = Read-Host "Seleccione una opción (1-4)"
    
    switch ($opcion) {
        1 { Get-NetFirewallRule | Where-Object { $_.Enabled -eq "True" } | Format-Table -AutoSize }
        2 { 
            $regla = Read-Host "Nombre de la regla a habilitar"
            Enable-NetFirewallRule -DisplayName $regla
            Write-Host "Regla $regla habilitada."
        }
        3 { 
            $regla = Read-Host "Nombre de la regla a deshabilitar"
            Disable-NetFirewallRule -DisplayName $regla
            Write-Host "Regla $regla deshabilitada."
        }
        4 { Write-Host "Saliendo..." }
        default { Write-Host "Opción no válida." }
    }
    if ($opcion -ne 4) { Read-Host "Presiona Enter para continuar..." }
} while ($opcion -ne 4)
