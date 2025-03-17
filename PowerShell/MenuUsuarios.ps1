# Función para mostrar el menú
function Show-Menu {
    Clear-Host
    Write-Host "=== MENU DE USUARIOS ==="
    Write-Host "1. Listar usuarios"
    Write-Host "2. Crear usuario"
    Write-Host "3. Eliminar usuario"
    Write-Host "4. Modificar usuario"
    Write-Host "5. Salir"
    Write-Host "======================="
}

# Bucle principal del menú
do {
    Show-Menu
    $opcion = Read-Host "Seleccione una opción"
    
    switch ($opcion) {
        1 {
            Write-Host "Listando usuarios..."
            Get-LocalUser | Select-Object Name | Out-Host
            pause
        }
        2 {
            $usuario = Read-Host "Ingrese nombre de usuario"
            $password = Read-Host "Ingrese contraseña" -AsSecureString
            New-LocalUser -Name $usuario -Password $password
            Write-Host "Usuario creado con éxito"
            pause
        }
        3 {
            $usuario = Read-Host "Ingrese usuario a eliminar"
            Remove-LocalUser -Name $usuario
            Write-Host "Usuario eliminado con éxito"
            pause
        }
        4 {
            $usuario = Read-Host "Ingrese usuario a modificar"
            $nuevoNombre = Read-Host "Ingrese nuevo nombre"
            Rename-LocalUser -Name $usuario -NewName $nuevoNombre
            Write-Host "Usuario modificado con éxito"
            pause
        }
        5 {
            Write-Host "Saliendo..."
            break
        }
        default {
            Write-Host "Opción no válida"
            pause
        }
    }
} while ($opcion -ne 5)
