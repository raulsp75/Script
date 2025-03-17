# Script para monitorear el uso de CPU y RAM en intervalos definidos por el usuario

# Definir la ruta del archivo de log
$logFile = "$(Get-Location)\cpu_ram_log.txt"

# Solicitar al usuario la cantidad de iteraciones
$iteraciones = Read-Host "Ingrese la cantidad de veces que desea monitorear (ej. 10)"

Write-Host "Monitoreo de CPU y RAM iniciado. Se ejecutará $iteraciones veces."

for ($i = 0; $i -lt $iteraciones; $i++) {
    # Obtener el porcentaje de uso de CPU usando WMI
    $cpuUsage = (Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average

    # Obtener el uso de RAM en MB
    $totalRAM = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1MB
    $freeRAM = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB
    $usedRAM = $totalRAM - $freeRAM

    # Obtener la fecha y hora actual
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Mostrar en consola
    Write-Host "$timestamp - CPU: $([math]::Round($cpuUsage, 2))% - RAM Usada: $([math]::Round($usedRAM, 2)) MB"

    # Guardar en el archivo de log
    "$timestamp - CPU: $([math]::Round($cpuUsage, 2))% - RAM Usada: $([math]::Round($usedRAM, 2)) MB" | Out-File -Append -FilePath $logFile

    # Esperar 1 segundo antes de la siguiente iteración
    Start-Sleep -Seconds 1
}
