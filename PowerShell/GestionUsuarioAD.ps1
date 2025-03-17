function Show-Menu {
    Clear-Host
    Write-Host "=== GESTIÓN DE USUARIOS AD ==="
    Write-Host "1. Crear nuevo usuario"
    Write-Host "2. Deshabilitar usuario"
    Write-Host "3. Desbloquear usuario"
    Write-Host "4. Salir"
}

do {
    Show-Menu
    $opcion = Read-Host "Seleccione una opción (1-4)"
    
    switch ($opcion) {
        1 { 
            $nombre = Read-Host "Nombre completo del usuario"
            $usuario = Read-Host "Nombre de usuario (samAccountName)"
            $ou = Read-Host "Ruta de la OU (ej: OU=Usuarios,DC=dominio,DC=com)"
            New-ADUser -Name $nombre -SamAccountName $usuario -Path $ou -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) -Enabled $true
            Write-Host "Usuario $usuario creado."
        }
        2 { 
            $usuario = Read-Host "Nombre de usuario a deshabilitar"
            Disable-ADAccount -Identity $usuario
            Write-Host "Usuario $usuario deshabilitado."
        }
        3 { 
            $usuario = Read-Host "Nombre de usuario a desbloquear"
            Unlock-ADAccount -Identity $usuario
            Write-Host "Usuario $usuario desbloqueado."
        }
        4 { Write-Host "Saliendo..." }
        default { Write-Host "Opción no válida." }
    }
    if ($opcion -ne 4) { Read-Host "Presiona Enter para continuar..." }
} while ($opcion -ne 4)
