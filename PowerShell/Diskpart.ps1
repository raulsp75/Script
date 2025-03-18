# Solicitar al usuario el número del disco a utilizar
$diskNumber = Read-Host "Ingrese el número del disco que desea limpiar y particionar"

# Obtener el tamaño del disco en GB
$diskSize = (Get-Disk -Number $diskNumber).Size / 1GB
Write-Output "El tamaño del disco seleccionado es: $diskSize GB"

# Confirmar si el usuario quiere proceder
$confirm = Read-Host "¿Desea limpiar y particionar el disco? (si/no)"
if ($confirm -ne "si") {
    Write-Output "Operación cancelada."
    exit
}

# Crear el script de Diskpart
echo "select disk $diskNumber" > diskpart_script.txt
echo "clean" >> diskpart_script.txt

echo "convert mbr" >> diskpart_script.txt

# Crear particiones de 1GB hasta llenar el disco
$remainingSize = $diskSize
$partitionNumber = 1
while ($remainingSize -ge 1) {
    echo "create partition primary size=1024" >> diskpart_script.txt
    echo "format fs=ntfs quick" >> diskpart_script.txt
    echo "assign" >> diskpart_script.txt
    $remainingSize -= 1
    $partitionNumber += 1
}

# Ejecutar Diskpart
Write-Output "Ejecutando Diskpart..."
diskpart /s diskpart_script.txt

Write-Output "Proceso completado. Se han creado todas las particiones disponibles."
