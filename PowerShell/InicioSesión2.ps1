$fecha_inicio = Read-Host "Introduzca una fecha de inicio (dd/MM/yyyy) "
$fecha_fin = Read-Host "Introduzca una fecha de fin (dd/MM/yyyy) "

Write-Host "Eventos de inicio de sesion: "

# Obtiene los eventos de inicio de sesion en el Log de Seguridad
# 4624 es el EventID para inicios de sesion exitosos en Windows
Get-EventLog -LogName Security -InstanceId 4624 -After $fecha_inicio -Before $fecha_fin | ForEach-Object {
	# Extrae la fecha y el nombre de usuario de cada evento
	$fechaEvento = $_.TimeGenerated
	$replacementStrings = $_.ReplacementStrings

	# Verifica si ReplacementStrings no es nulo y tiene suficientes elementos
	if ($replacementStrings -and $replacementStrings.Count -gt 5) {
		$usuario = $replacementStrings [5] # La posicion [5] en ReplacementStrings es donde se encuentra el nombre de usuario
		# Muestra los resultados
		Write-Output "Fecha: $($fechaEvento.ToString('dd/MM/yyyy HH:mm:ss')) - Usuario: $usuario"
	} else {
		Write-Output "Fecha: $($fechaEvento.ToString('dd/MM/yyyy HH:mm:ss')) - Usuario: No disponible"
	}
}

#################### OJO!!! -> Si quereis que enseñe todos los distintos a SYSTEM:

$fecha_inicio = Read-Host "Introduzca una fecha de inicio (dd/MM/yyyy) "
$fecha_fin = Read-Host "Introduzca una fecha de fin (dd/MM/yyyy) "

Write-Host "Eventos de inicio de sesion: "

# Obtiene los eventos de inicio de sesion en el Log de Seguridad
# 4624 es el EventID para inicios de sesion exitosos en Windows
Get-EventLog -LogName Security -InstanceId 4624 -After $fecha_inicio -Before $fecha_fin | ForEach-Object {
	# Extrae la fecha y el nombre de usuario de cada evento
	$fechaEvento = $_.TimeGenerated
	$replacementStrings = $_.ReplacementStrings

	# Verifica si ReplacementStrings no es nulo y tiene suficientes elementos
	if ($replacementStrings -and $replacementStrings.Count -gt 5) {
		$usuario = $replacementStrings [5] # La posicion [5] en ReplacementStrings es donde se encuentra el nombre de usuario

		#Filtra eventos donde el usuario sea distinto a "SYSTEM"
		if ($usuario -ne "SYSTEM") {
		# Muestra los resultados
		Write-Output "Fecha: $($fechaEvento.ToString('dd/MM/yyyy HH:mm:ss')) - Usuario: $usuario"
		}
	} else {
		Write-Output "Fecha: $($fechaEvento.ToString('dd/MM/yyyy HH:mm:ss')) - Usuario: No disponible"
	}
}
