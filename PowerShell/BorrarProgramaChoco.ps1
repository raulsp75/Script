#Leer el contenido del archivo
$programas = Get-Content -Path "ruta"

#Obtener la lista de paquetes instalados
$instalados = choco list
$instalados

foreach ($programa in $programas) {
	if ($programas -contains $programa) {
		Write-Host "Desinstalando $programa" 
		choco uninstall $programa
	} else {
		Write-Host "Programa no encontrad: $programa"
	}	
}

#Primero, obtendremos el contenido que esté dentro del archivo txt creado. A continuación, listaremos
#los programas instalados y reconocidos por el sistema (esto es a modo de confirmación de que estén
#instalados). Tras ello me apoyo de un foreach para así poder comprobar que los programas en el interior
#estén instalados y recogidos por el Chocolatey. En caso de estar registrado en el directorio lib de Chocolatey,
#este será desinstalado, y de no ser así el programa se identificará como extraviado.
