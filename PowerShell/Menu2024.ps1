# Verifica si el script se está ejecutando con privilegios elevados
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Este script debe ejecutarse como Administrador." -ForegroundColor Red
    exit
}

Import-Module ActiveDirectory

function Mostrar-InformacionDominio {
    $nombreEquipo = $env:COMPUTERNAME
    $nombreDominio = (Get-ADDomain).Name
    $OUs = (Get-ADOrganizationalUnit -Filter *).Count
    $grupos = (Get-ADGroup -Filter *).Count
    $usuarios = (Get-ADUser -Filter *).Count
    
    Write-Host "Nombre del equipo: $nombreEquipo"
    Write-Host "Nombre del Dominio: $nombreDominio"
    Write-Host "Número de Unidades Organizativas: $OUs"
    Write-Host "Número de Grupos: $grupos"
    Write-Host "Número de Usuarios: $usuarios"
}

function Crear-OU {
    param([string]$nombreOU)
    New-ADOrganizationalUnit -Name $nombreOU -Path "DC=$(($env:USERDNSDOMAIN).Split('.') -join ',DC=')" -ProtectedFromAccidentalDeletion $false
    Write-Host "Unidad Organizativa '$nombreOU' creada con éxito."
}

function Ver-MiembrosOU {
    param([string]$nombreOU)
    Get-ADUser -SearchBase "OU=$nombreOU,DC=$(($env:USERDNSDOMAIN).Split('.') -join ',DC=')" -Filter * | Select-Object Name
}

function Crear-Grupo {
    param([string]$nombreGrupo)
    New-ADGroup -Name $nombreGrupo -GroupScope Global -Path "CN=Users,DC=$(($env:USERDNSDOMAIN).Split('.') -join ',DC=')"
    Write-Host "Grupo '$nombreGrupo' creado con éxito."
}

function Ver-MiembrosGrupo {
    param([string]$nombreGrupo)
    Get-ADGroupMember -Identity $nombreGrupo | Select-Object Name
}

function Crear-Usuario {
    param([string]$nombreUsuario, [string]$contraseña)
    $securePass = ConvertTo-SecureString $contraseña -AsPlainText -Force
    New-ADUser -Name $nombreUsuario -AccountPassword $securePass -Enabled $true
    Write-Host "Usuario '$nombreUsuario' creado con éxito."
}

function Agregar-UsuarioGrupo {
    param([string]$nombreUsuario, [string]$nombreGrupo)
    Add-ADGroupMember -Identity $nombreGrupo -Members $nombreUsuario
    Write-Host "Usuario '$nombreUsuario' agregado al grupo '$nombreGrupo'."
}

function Mover-UsuarioOU {
    param([string]$nombreUsuario, [string]$nuevaOU)
    $dn = "OU=$nuevaOU,DC=$(($env:USERDNSDOMAIN).Split('.') -join ',DC=')"
    Get-ADUser -Identity $nombreUsuario | Move-ADObject -TargetPath $dn
    Write-Host "Usuario '$nombreUsuario' movido a '$nuevaOU'."
}

function Ver-InfoUsuario {
    param([string]$nombreUsuario)
    Get-ADUser -Identity $nombreUsuario -Properties * | Select-Object Name, SamAccountName, Enabled, EmailAddress
}

function Monitorizar-Procesos {
    param([string]$orden)
    Get-Process | Sort-Object $orden | Select-Object Name, ID, CPU, WS
}

function Crear-CarpetaRed {
    param([string]$ruta)
    New-Item -ItemType Directory -Path $ruta
    New-SmbShare -Name "Compartido" -Path $ruta -FullAccess "Everyone"
    Write-Host "Carpeta de red '$ruta' creada y compartida."
}

function Crear-Volumen {
    param([int]$numDisco)
    Initialize-Disk -Number $numDisco -PartitionStyle GPT
    New-Partition -DiskNumber $numDisco -UseMaximumSize -AssignDriveLetter | Format-Volume -FileSystem NTFS -Confirm:$false
    Write-Host "Volumen creado con éxito en el disco $numDisco."
}

do {
    Write-Host "=========================================="
    Write-Host "Menú de Opciones:" -ForegroundColor Cyan
    Write-Host "1. Mostrar información del dominio"
    Write-Host "2. Crear nueva Unidad Organizativa"
    Write-Host "3. Ver miembros de una Unidad Organizativa"
    Write-Host "4. Crear nuevo grupo"
    Write-Host "5. Ver miembros de un grupo"
    Write-Host "6. Crear nueva cuenta de usuario"
    Write-Host "7. Agregar un usuario a un grupo"
    Write-Host "8. Mover usuario a otra Unidad Organizativa"
    Write-Host "9. Ver información de un usuario especifico"
    Write-Host "10. Monitorización de procesos"
    Write-Host "11. Crear carpeta en red compartida"
    Write-Host "12. Crear un volumen en un disco"
    Write-Host "0. Salir"
    
    $opcion = Read-Host "Seleccione una opción"
    
    switch ($opcion) {
        "1" { Mostrar-InformacionDominio }
        "2" { Crear-OU (Read-Host "Ingrese el nombre de la Unidad Organizativa") }
        "3" { Ver-MiembrosOU (Read-Host "Ingrese el nombre de la Unidad Organizativa") }
        "4" { Crear-Grupo (Read-Host "Ingrese el nombre del grupo") }
        "5" { Ver-MiembrosGrupo (Read-Host "Ingrese el nombre del grupo") }
        "6" { Crear-Usuario (Read-Host "Ingrese el nombre del usuario") (Read-Host "Ingrese la contraseña del usuario") }
        "7" { Agregar-UsuarioGrupo (Read-Host "Ingrese el nombre del usuario") (Read-Host "Ingrese el nombre del grupo") }
        "8" { Mover-UsuarioOU (Read-Host "Ingrese el nombre del usuario") (Read-Host "Ingrese la nueva Unidad Organizativa") }
        "9" { Ver-InfoUsuario (Read-Host "Ingrese el nombre del usuario") }
        "10" { Monitorizar-Procesos (Read-Host "Ordenar por (Name, ID, CPU, WS)") }
        "11" { Crear-CarpetaRed (Read-Host "Ingrese la ruta de la carpeta compartida") }
        "12" { Crear-Volumen (Read-Host "Ingrese el número del disco") }
    }
} until ($opcion -eq "0")
