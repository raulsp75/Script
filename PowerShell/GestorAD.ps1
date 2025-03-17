# Función para mostrar el menú
function Show-Menu {
    Clear-Host
    Write-Host "============================================="
    Write-Host "MENÚ DE GESTIÓN DEL CONTROLADOR DE DOMINIO"
    Write-Host "============================================="
    Write-Host "1. Mostrar información del dominio"
    Write-Host "2. Crear nueva Unidad Organizativa (OU)"
    Write-Host "3. Ver miembros de una Unidad Organizativa (OU)"
    Write-Host "4. Crear nuevo grupo"
    Write-Host "5. Crear nueva cuenta de usuario"
    Write-Host "0. Salir"
    Write-Host "============================================="
}

# Función para mostrar la información del dominio
function Show-DomainInfo {
    $computerName = $env:COMPUTERNAME
    $domainName = (Get-ADDomain).DNSRoot
    $ous = (Get-ADOrganizationalUnit -Filter *).Count
    $groups = (Get-ADGroup -Filter *).Count
    $users = (Get-ADUser -Filter *).Count

    Write-Host "Nombre del equipo: $computerName"
    Write-Host "Nombre del Dominio: $domainName"
    Write-Host "Número de Unidades Organizativas (OU): $ous"
    Write-Host "Número de Grupos: $groups"
    Write-Host "Número de Usuarios: $users"
}

# Función para crear una nueva Unidad Organizativa (OU)
function Create-NewOU {
    $ouName = Read-Host "Introduce el nombre de la nueva Unidad Organizativa (OU)"
    $ouPath = Read-Host "Introduce la ruta donde se creará la OU (ej. 'DC=dominio,DC=com')"
    
    try {
        New-ADOrganizationalUnit -Name $ouName -Path $ouPath
        Write-Host "Unidad Organizativa '$ouName' creada con éxito en '$ouPath'."
    } catch {
        Write-Host "Error al crear la Unidad Organizativa: $_"
    }
}

# Función para ver los miembros de una Unidad Organizativa (OU)
function Show-OUMembers {
    $ouName = Read-Host "Introduce el nombre de la Unidad Organizativa (OU)"
    $ouPath = "OU=$ouName," + (Get-ADDomain).DistinguishedName

    $users = Get-ADUser -Filter * -SearchBase $ouPath
    $groups = Get-ADGroup -Filter * -SearchBase $ouPath

    Write-Host "Usuarios en la OU '$ouName':"
    $users | ForEach-Object { Write-Host $_.Name }

    Write-Host "Grupos en la OU '$ouName':"
    $groups | ForEach-Object { Write-Host $_.Name }
}

# Función para crear un nuevo grupo
function Create-NewGroup {
    $groupName = Read-Host "Introduce el nombre del nuevo grupo"
    $groupPath = Read-Host "Introduce la ruta donde se creará el grupo (ej. 'OU=Grupos,DC=dominio,DC=com')"
    
    try {
        New-ADGroup -Name $groupName -GroupScope Global -Path $groupPath
        Write-Host "Grupo '$groupName' creado con éxito en '$groupPath'."
    } catch {
        Write-Host "Error al crear el grupo: $_"
    }
}

# Función para crear una nueva cuenta de usuario
function Create-NewUser {
    $userName = Read-Host "Introduce el nombre de usuario"
    $userPath = Read-Host "Introduce la ruta donde se creará el usuario (ej. 'OU=Usuarios,DC=dominio,DC=com')"
    $groupName = Read-Host "Introduce el nombre del grupo al que pertenecerá el usuario"
    
    $password = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

    try {
        New-ADUser -Name $userName -AccountPassword $password -Enabled $true -Path $userPath -ChangePasswordAtLogon $true
        Add-ADGroupMember -Identity $groupName -Members $userName
        Write-Host "Usuario '$userName' creado con éxito en '$userPath' y añadido al grupo '$groupName'."
    } catch {
        Write-Host "Error al crear el usuario: $_"
    }
}

# Bucle principal del menú
do {
    Show-Menu
    $option = Read-Host "Selecciona una opción (0-5)"

    switch ($option) {
        1 { Show-DomainInfo }
        2 { Create-NewOU }
        3 { Show-OUMembers }
        4 { Create-NewGroup }
        5 { Create-NewUser }
        0 { Write-Host "Saliendo del menú..." }
        default { Write-Host "Opción no válida. Inténtalo de nuevo." }
    }

    if ($option -ne 0) {
        Read-Host "Presiona Enter para continuar..."
    }
} while ($option -ne 0)
