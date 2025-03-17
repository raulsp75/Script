# Verifica si se ha proporcionado un parámetro
if ($args.Count -eq 0) {
    Write-Host "Uso: .\EjecutarPrograma.ps1 <ruta_del_programa>"
    exit
}

# Obtiene la ruta del programa desde el primer parámetro
$programa = $args[0]

# Verifica si el archivo existe
if (-Not (Test-Path $programa)) {
    Write-Host "Error: El archivo '$programa' no existe."
    exit
}

# Ejecuta el programa
Write-Host "Ejecutando el programa: $programa"
Start-Process -FilePath $programa
