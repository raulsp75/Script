# A tener en cuenta: Los Gets en PowerShell a veces se buguean, dar un par de vueltas al menú para solucionar el error, opcion 1 x 3

# Creamos una funcion de menu
function menu_grupos {
    Write-Host "Bienvenido al menú de grupos"
    Write-Host "1) Listar grupos"
    Write-Host "2) Listar miembros de un grupos"
    Write-Host "3) Crear grupo"
    Write-Host "4) Eliminar grupo"
    Write-Host "5) Crear miembro de un grupo"
    Write-Host "6) Eliminar miembro de un grupo"
    Write-Host "7) Salir del menu"

    # Obetenemos la opcion
    $opcion = Read-Host "Elige una de las opciones"
    # Cambiamos entre la opcion escogida y ejecutamos
    switch ($opcion) {
        1 {
            Write-Host "Estos son los grupos del sistema"
            Get-LocalGroup
            menu_grupos
            # Mostramos los grupos y volvemos al menu
        }
        2 {
            $grupo = Read-Host "Dime el grupo del que quieres saber los usuarios"
            Write-Host "Estos son los usuarios que pertenecen al grupo $grupo"
            Get-LocalGroupMember -Name $grupo
            menu_grupos
            # Listamos los usuarios y volvemos al menu
        }
        3 {
            Write-Host "Procedemos con la creación del grupo"
            $grupo = Read-Host "Dime el nombre del nuevo grupo"
            New-LocalGroup -Name $grupo -Description "Grupo creado desde menu iteractivo"
            Write-Host "El grupo se creó correctamente"
            menu_grupos
            # Creamos el grupo y volvemos al menu
        }
        4 {
            Write-Host "Procedemos con la eliminacion del grupo"
            $grupo = Read-Host "Dime el nombre del grupo"
            Remove-LocalGroup -Name $grupo
            Write-Host "El grupo se eliminó correctamente"
            menu_grupos
            # Eliminamos el grupo y volvemos al menu
        }
        5 {
            Write-Host "Tanto el usuario como el grupo debe estar creado anteriormente"
            $usuario = Read-Host "Dime el nombre del usuario"
            $grupo = Read-Host "Dime el grupo al que vamos añadir el usuario"
            Add-LocalGroupMember -Group $grupo -Member $usuario
            Write-Host "El usuario se añadió correctamente"
            Get-LocalGroupMember -Group $grupo | Where-Object { $_.Name -eq $usuario }
            menu_grupos
            # Añadimos el usuario al grupo y volvemos al menu
        }
        6 {
            $usuario = Read-Host "Dime el usuario que vamos a eliminar de cierto grupo"
            $grupo = Read-Host "Dime el cierto grupo"
            Remove-LocalGroupMember -Group $grupo -Member $usuario
            Write-Host "El usuario se eliminó correctamente"
            menu_grupos
            # Eliminamos el usuario del grupo y volvemos al menu
        }
        7 {
            Write-Host "Saliendo del menú de grupos..."
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

menu_grupos #Llamamos al menu
