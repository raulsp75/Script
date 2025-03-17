# Rutas
$ruta = "C:\Contenidos&Recursos\Usuarios.csv"
$ruta2 = "C:\Contenidos&Recursos\ISO.csv"

# Importamos los datos
$archivo = Import-Csv -Path $ruta
$iso = Import-Csv -Path $ruta2

# Creamos la funcion para obtener el pais estandarizado
function CCU($ombrePais) {
return ($iso | Where-Object {$_.Pais -eq $nombrePais}).Codigo
}

# Ruta de la Unidad Organizativa appnube
$ouPath = "OU=appnube, DC=blas24,DC=sistemas"

# Nombre de las carpetas para usuarios y grupos
$usuariosFolder = "USUARIOS"
$gruposFolder = "GRUPOS2"
# Rutas completas de las carpetas
$usuariosFolderPath = "OU=$usuariosFolder, $ouPath"
$gruposFolderPath = "OU=$gruposFolder, $ouPath"

# Verificar si las carpetas ya existen, si no, crearlas
if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $usuariosFolder})) {
	New-ADOrganizationalUnit -Name $usuariosFolder -Path $ouPath
	Write-Host "Carpeta '$usuariosFolder' creada exitosamente en la Unidad Organizativa 'appnube'."
}

if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $gruposFolder})) {
	New-ADOrganizationalUnit -Name $gruposFolder -Path $ouPath
	Write-Host "Carpeta '$gruposFolder' creada exitosamente en la Unidad Organizativa 'appnube'."
}

# Recorremos cada usuario
foreach ($user in $archivo) {
	$nombre = $user.Nombre
	$apellido = $user.Apellidos
	$correo = $user.email
	$contra = $user.Contrasena
	$grupo = $user. Grupo
	$pais = $user.Pais

	# Creamos el nombre de usuario
	$User = $nombre.Substring(0,1).ToLower() + $apellido.ToLower()
	# Obtenemos el código del pais
	$codigoPais = CCU $pais
	try {
		# Crear el usuario en la carpeta de usuarios
		New-ADUser -Name "$nombre $apellido"
		-GiverName "$nombre"
		-Surname "$apellido"
		-SamAccountName "$User" "
		-UserPrincipalName "$correo"
		-AccountPassword (ConvertTo-SecureString $contra -AsPlainText -Force) '
		-Path $usuariosFolderPath
		-EmailAddress $correo
		-Country $codigoPais
		-Enabled $true
		# Veriticar s1 el usuario se ha creado exitosamente consultando por el mismo
		$nuevouser = Get-ADUser -Filter "SamAccountName -eq '$User'"
		if ($nuevouser) {
			# Verificar si el grupo existe en la carpeta de grupos, si no, crearlo
			if (-not (Get-ADGroup -Filter {Name -eq $grupo} -SearchBase $gruposFolderPath)) {
				New-ADGroup -Name $grupo -GroupScope Global -Path $gruposFolderPath
				Write-Host "Grupo $grupo creado exitosamente en la carpeta de grupos."
			}
			
			# Intentar agregar el usuario al grupo especificado
			try {
				Add-ADGroupMember -Identity $grupo -Members $nuevouser -ErrorAction Stop
				Write-Host "Usuario $User creado y agregado al grupo $grupo exitosamente."
			} catch {
			Write-Host "Error al agregar usuario $User al grupo $grupo $_"
				}
		} else {
			Write-Host "El usuario $User no se creo correctamente."
		}
	} catch {
		Write-Host "Error al crear el usuario: $User. Error: $_"
	}
}
