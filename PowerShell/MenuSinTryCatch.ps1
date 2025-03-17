# Importar modulo de Active Directory
Import-Module ActiveDirectory

# Función para mostrar el menú
function Show-Menu {
	Clear-Host
	Write-Host "Seleccione una opción:"
	Write-Host "1. Mostrar información del dominio"
	Write-Host "2. Crear nueva Unidad Organizativa"
	Write-Host "3. Ver miembros de una Unidad Organizativa"
	Write-Host "4. Crear nuevo grupo"
	Write-Host "5. Crear nueva cuenta de usuario"
	Write-Host "0. Salir"
}
# Funcion para mostrar informacion del dominio
function Show-DomainInfo {
	$domain = Get-ADDomain
	$hostname = $env:COMPUTERNAME

	$OUs = Get-ADOrganizationalUnit -Filter * | Measure-Object
	$groups = Get-ADGroup -Filter * | Measure-Object
	$users = Get-ADUser -Filter * | Measure-Object

	Write-Host "Nombre del equipo: $hostname"
	Write-Host "Nombre del Dominio: $($domain.DNSRoot)"
	Write-Host "Numero de Unidades Organizativas: $($OUs.Count)"
	Write-Host "Numero de Grupos: $($groups.Count)"
	Write-Host "Numero de Usuarios: $($users.Count)"
}

# Función para crear una nueva Unidad Organizativa
function Create-ou {
	param (
	  [string] $OUName
	)
	# Obtener el dominio actual dinámicamente
	$domain = (Get-ADDomain).DistinguishedName
	$newOU = New-ADOrganizationalUnit -Name $OUName -Path $domain
	Write-Host "Unidad Organizativa '$OUName' creada exitosamente en el dominio '$domain'."
}

# Función para ver miembros de una Unidad Organizativa
function View-OUUsers {
	param (
	  [string] $OUName
	)
	# Obtener la OU especificada
	$OU = Get-ADOrganizationalUnit -Filter "Name -eq '$OUName'"

	if ($OU) {
	# Buscar todos los usuarios dentro de esa OU (incluyendo sub-OUs si existen)
	$users = Get-ADUser -Filter # -SearchBase $OU.DistinguishedName -SearchScope Subtree

		if ($users.Count -gt 0) {
			Write-Host "Usuarios en la Unidad Organizativa ' $OUName' :"
			$users | Select-Object Name, SamAccountName, DistinguishedName | Format-Table -AutoSize
		} else {
			Write-Host "No se encontraron usuarios en la Unidad Organizativa ' $OUName'."
		}	
	} else {
		Write-Host "Unidad Organizativa 'SOUName' no encontrada."
	}
}

# Funcion para crear un nuevo usuario
function Create-User {
	param (
	  [string]$UserName,
	  [string]$GroupName,
	  [string] $OUName
	)
	# Verificar si la OU existe
	$OU = Get-ADOrganizationalUnit -Filter "Name -eq ' $OUName'"

	if ($OU) {
		# Crear el nuevo usuario
		$password = ConvertTo-SecureString "ContrasemaGenerica123!" -AsPlainText -Force
		$newUser = New-ADUser -Name $UserName
			-SamAccountName $UserName
			-AccountPassword $password
			-PasswordNeverExpires $false
			-ChangePasswordAtLogon $true
			-Enabled $true
			-Path $OU.DistinguishedName
		Write-Host "Usuario '$UserName' creado exitosamente en la OU 'SOUName'."

		# Verificar si el grupo existe
		$group = Get-ADGroup -Filter "Name -eq ' $GroupName'"
		if ($group) {
			# Añadir el usuario al grupo
			Add-ADGroupMember -Identity $GroupName -Members $UserName
			Write-Host "Usuario '$UserName' añadido exitosamente al grupo ' $GroupName'."
		} else {
			Write-Host "Error: El grupo ' $GroupName' no existe."
		}
	} else {
		Write-Host "Error: La Unidad Organizativa '$OUName' no existe."
	}
}

# Menú interactivo
do {
	Show-Menu
	$selection = Read-Host "Seleccione una opción"
	switch ($selection) {
	  "1" {
		Show-DomainInfo
	  }
	  "2" {
		$OUName = Read-Host "Ingrese el nombre de la nueva Unidad Organizativa"
	  	Create-OU -OUName $OUName
	  }
	  "3" {
		$OUName = Read-Host "Ingrese el nombre de la Unidad Organizativa"
		View-OUUsers -OUName $OUName
	  }
	  "4" {
		$GroupName = Read-Host "Ingrese el nombre del nuevo grupo"
		Create-Group -GroupName $GroupName
	  }
	  "5" {
		$UserName = Read-Host "Ingrese el nombre del nuevo usuario"
		$GroupName = Read-Host "Ingrese el nombre del grupo al que pertenecerá el usuario"
		$OUName = Read-Host "Ingrese el nombre de la Unidad Organizativa donde se creara el usuario"
		Create-User -UserName $UserName -GroupName $GroupName -OUName $OUName
	  }
	  "0" {
		Write-Host "Saliendo del menú ... "
	  }
	  default {
		Write-Host "Opcion invalida. Intente de nuevo."
	  }
	}
	if ($selection -ne "0") {
	  Pause
	}
 } while ($selection -ne "0")
