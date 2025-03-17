# A tener en cuenta: Los Gets en PowerShell a veces se buguean, dar un par de vueltas al menú para solucionar el error, opcion 1 x 3

# Creamos una funcion de menu
function menu_usuarios {
    Write-Host "Bienvenido al menú de usuarios"
    Write-Host "1) Listar Usuarios"
    Write-Host "2) Crear usuarios"
    Write-Host "3) Eliminar usuarios"
    Write-Host "4) Modificar usuarios"
    Write-Host "5) Salir"

    # Obetenemos la opcion
    $opcion = Read-Host "Elige una de las opciones"
    # Cambiamos entre la opcion escogida y ejecutamos
    switch ($opcion) {
        1 {
            Write-Host "Estos son los usuarios del sistema"
            Get-LocalUser
            menu_usuarios
            # Mostramos los usuarios y volvemos al menu
        }
        2 {
            Write-Host "Empecemos con la creación de usuarios"
            $nombre = Read-Host "Dime el nombre del usuario"
            $contraseña = Read-Host "Dime la contraseña que tendrá el usuario" -AsSecureString
            New-LocalUser -Name $nombre -Password $contraseña -Description "Cuenta creada a través del menú interactivo"
            Write-Host "El usuario se creó correctamente"
            Get-LocalUser -Name $nombre
            menu_usuarios
            # Creamos el usuarios y volvemos al menu
        }
        3 {
            Write-Host "Empecemos con la eliminacion de usuarios"
            $nombre = Read-Host "Dime el nombre del usuario"
            Remove-LocalUser -Name $nombre
            Get-LocalUser
            menu_usuarios
            # Eliminamos el usuarios y volvemos al menu
        }
        4 {
            Write-Host "Empecemos con la modificacion de usuarios"
            $nombre = Read-Host "Dime el nombre del usuario que quieras modificar"
            $nombreNuevo = Read-Host "Dime el nuevo nombre"
            Rename-LocalUser -Name $nombre -NewName $nombreNuevo
            Get-LocalUser
            menu_usuarios
            # Modificamos el usuarios y volvemos al menu
        }
        5 {
            Write-Host "Saliendo del menú de usuarios..."
            return
            # Salimos del menu
        }
        default {
            Write-Host "Opción no válida. Por favor, intenta de nuevo."
            menu_usuarios
            # Opcion invalida y volvemos al menu
        }
    }
}

menu_usuarios #Llamamos al menu
