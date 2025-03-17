#Enunciado del Script
#Proporciona una interfaz de línea de comandos para que los administradores de sistema puedan realizar tareas comunes de administración de usuarios 
#y unidades organizativas de manera eficiente. Crea un menú con las siguientes opciones:
#1. Mostrar Información del Dominio:
#Proporciona detalles sobre el dominio actual y lista todas las Unidades Organizativas (UO) disponibles.
#2. Crear una Nueva Unidad Organizativa (UO):
#Permite al usuario crear nuevas UOs en el dominio especificando un nombre y la ruta de la UO.
#3. Eliminar un Grupo del Dominio:
#Muestra todos los grupos disponibles y permite al usuario seleccionar uno para eliminar, con una confirmación de la acción.
#4. Modificar Usuarios del Dominio:
#Lista todos los usuarios disponibles y permite al usuario modificar los detalles de un usuario existente (nombre, teléfono y correo electrónico).
#5. Salir
# Función para mostrar el menú principal
function Show-Menu {
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "   Administrador de Dominio AD" -ForegroundColor Green
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "0. Salir"
    Write-Host "1. Mostrar Información del dominio"
    Write-Host "2. Crear una nueva Unidad Organizativa"
    Write-Host "3. Eliminar un grupo del dominio"
    Write-Host "4. Modificar un usuario del dominio"
    Write-Host "===================================" -ForegroundColor Cyan
}

# Función 1: Mostrar información del dominio y listar Unidades Organizativas (UO)
function Show-DomainInfoAndOU {
    # Obtener información del dominio
    $domain = Get-ADDomain
    Write-Host "Nombre del Dominio: $($domain.Name)"
    Write-Host "Controlador de Dominio Principal: $($domain.PDCEmulator)" 
    Write-Host "`nUnidades Organizativas (UO) en el Dominio:"
    Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName | ForEach-Object {
        Write-Host "Nombre: $($_.Name), DN: $($_.DistinguishedName)"
    }
}

# Función 2: Crear una nueva Unidad Organizativa (UO)
function Create-OU {
    $ouName = Read-Host "Introduce el nombre de la nueva Unidad Organizativa"
    $ouPath = Read-Host "Introduce la ruta completa donde se creará (Ejemplo, 'DC=raul,DC=aws')"

    # Verificar si la UO ya existe
    $existingOU = Get-ADOrganizationalUnit -Filter { Name -eq $ouName } -ErrorAction SilentlyContinue

    if ($existingOU) {
        Write-Host "La Unidad Organizativa '$ouName' ya existe en '$ouPath'."
    } else {
        try {
            New-ADOrganizationalUnit -Name $ouName -Path $ouPath
            Write-Host "Unidad Organizativa '$ouName' creada exitosamente en '$ouPath'."
            # Listar UOs existentes después de la creación
            Show-ExistingOUs
        } catch {
            Write-Host "Error al crear la Unidad Organizativa: $_" -ForegroundColor Red
        }
    }
}

# Función para listar UOs existentes
function Show-ExistingOUs {
    Write-Host "`nUnidades Organizativas (UO) actuales en el Dominio:"
    Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName | ForEach-Object {
        Write-Host "Nombre: $($_.Name), DN: $($_.DistinguishedName)"
    }
}

# Función 3: Eliminar un grupo del dominio
function List-And-Remove-Group {
    Write-Host "`nGrupos disponibles en el dominio:"
    Get-ADGroup -Filter * | Select-Object Name | ForEach-Object {
        Write-Host "Grupo: $($_.Name)"
    }
    # Solicitar al usuario el nombre del grupo a eliminar
    $groupName = Read-Host "`nIntroduce el nombre del grupo a eliminar"
    $group = Get-ADGroup -Filter { Name -eq $groupName } -ErrorAction SilentlyContinue
    
    if ($group) {
        # Confirmar eliminación
        $confirm = Read-Host "¿Está seguro de que desea eliminar el grupo '$groupName'? (s/n)"
        if ($confirm -eq 's') {
            Remove-ADGroup -Identity $group -Confirm:$false
            Write-Host "Grupo '$groupName' eliminado exitosamente."
        } else {
            Write-Host "Eliminación cancelada."
        }
    } else {
        Write-Host "El grupo '$groupName' no existe." -ForegroundColor Red
    }
}

# Función 4: Modificar usuarios del dominio
function List-Users {
    Write-Host "`nUsuarios disponibles en el dominio:"
    Get-ADUser -Filter * | Select-Object SamAccountName, GivenName, Surname | ForEach-Object {
        Write-Host "Usuario: $($_.SamAccountName), Nombre: $($_.GivenName), Apellido: $($_.Surname)"
    }
}
function Modify-User {
    List-Users  # Llamar a la función para listar usuarios

    $username = Read-Host "`nIntroduce el nombre del usuario a modificar"
    $user = Get-ADUser -Filter { SamAccountName -eq $username } -ErrorAction SilentlyContinue

    if ($user) {
        $newName = Read-Host "Introduce el nuevo nombre (dejar en blanco para no modificar)"
        $newPhone = Read-Host "Introduce el nuevo teléfono (dejar en blanco para no modificar)"
        $newEmail = Read-Host "Introduce el nuevo email (dejar en blanco para no modificar)"

        # Crear un objeto para almacenar las propiedades a modificar
        $propertiesToUpdate = @{}

        # Agregar propiedades solo si no están en blanco
        if ($newName) { 
            $propertiesToUpdate['GivenName'] = $newName 
        }
        if ($newPhone) { 
            $propertiesToUpdate['telephoneNumber'] = $newPhone 
        }
        if ($newEmail) { 
            $propertiesToUpdate['mail'] = $newEmail 
        }

        if ($propertiesToUpdate.Count -gt 0) {
            try {
                Set-ADUser -Identity $user -Replace $propertiesToUpdate
                Write-Host "Usuario '$username' modificado exitosamente."
            } catch {
                # Manejo de errores más específico
                if ($_.Exception.Message -match "nombre o valor de servicio de directorios especificado no existe") {
                    Write-Host "Error: uno de los atributos que intenta modificar no existe." -ForegroundColor Red
                } else {
                    Write-Host "Error al modificar el usuario: $_" -ForegroundColor Red
                }
            }
        } else {
            Write-Host "No se han realizado cambios."
        }
    } else {
        Write-Host "El usuario '$username' no existe." -ForegroundColor Red
    }
}

# Bucle principal para mostrar el menú y ejecutar las opciones
do {
    Show-Menu
    $choice = Read-Host "Seleccione una opción"

    switch ($choice) {
        1 { Show-DomainInfoAndOU }
        2 { Create-OU }
        3 { List-And-Remove-Group }
        4 { Modify-User }
        0 { Write-Host "Saliendo..." }
        default { Write-Host "Opción no válida. Intente nuevamente." -ForegroundColor Red }
    }

} while ($choice -ne 0)
