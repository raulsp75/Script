#Crea un script en PowerShell que permita al usuario seleccionar una de las siguientes acciones: 
#1. Mostrar programas que se ejecutan al inicio de sesión: Muestra por pantalla los programas que se inician automáticamente al iniciar sesión en el sistema. 
#2. Guardar un listado de procesos en CSV e imprimir: Genera un archivo CSV con un listado de los procesos en ejecución y muestra su contenido por pantalla. 
#3. Listar y detener procesos con alto consumo de CPU: Lista los procesos que tienen un alto consumo de CPU y detiene el proceso que más recursos consume. 
#4. Mostrar y detener procesos con más de 100 MB de memoria: Muestra los procesos cuya zona de memoria para trabajar es mayor de 100 MB y detén esos procesos. 
#5. Salir: 
#Finaliza el scrip

# Función para mostrar el menú
function Mostrar-Menu() {
    Write-Host "Menú Principal"
    Write-Host "1. Mostrar programas que se ejecutan al inicio de sesión"
    Write-Host "2. Guardar un listado de procesos en CSV e imprimir"
    Write-Host "3. Listar y detener proceso con más consumo de CPU"
    Write-Host "4. Listar y detener procesos que consuman más de 100 MB de memoria"
    Write-Host "5. Salir"
}

# Función para mostrar los programas que se ejecutan al inicio de sesión
function Mostrar-Programas-Inicio() {
    Write-Host "Programas que se ejecutan al inicio de sesión:"
    $programas = Get-CimInstance -ClassName Win32_StartupCommand | Select-Object Name, Command, Location
    if ($programas) {
        $programas | Format-Table -AutoSize
    } else {
        Write-Host "No se encontraron programas que se ejecuten al inicio de sesión."
    }
}

# Función para guardar un listado de procesos en CSV e imprimir
function Guardar-Procesos-CSV() {
    $procesos = Get-Process | Select-Object Name, Id, CPU, WorkingSet
    $rutaCSV = "$pwd\procesos.csv"
    $procesos | Export-Csv -Path $rutaCSV -NoTypeInformation
    Write-Host "Listado de procesos guardado en: $rutaCSV"
    Write-Host "Contenido del archivo CSV:"
    Get-Content $rutaCSV
}

# Función para listar y detener el proceso con más consumo de CPU
function Detener-Proceso-Alto-CPU() {
    $procesoAltoCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 1
    Write-Host "Proceso con mayor consumo de CPU: $($procesoAltoCPU.Name) (ID: $($procesoAltoCPU.Id))"
    Stop-Process -Id $procesoAltoCPU.Id -Force
    Write-Host "Proceso detenido."
}

# Función para listar y detener procesos que consumen más de 100 MB de memoria
function Detener-Procesos-Alta-Memoria() {
    $procesosAltoMem = Get-Process | Where-Object { $_.WorkingSet -gt 100MB }
    if ($procesosAltoMem) {
        Write-Host "Procesos que consumen más de 100 MB de memoria:"
        $procesosAltoMem | Select-Object Name, Id, @{Name="Memoria (MB)";Expression={($_.WorkingSet/1MB).ToString("F2")}}
        foreach ($proceso in $procesosAltoMem) {
            Write-Host "Deteniendo proceso: $($proceso.Name) (ID: $($proceso.Id))"
            Stop-Process -Id $proceso.Id -Force
        }
    } else {
        Write-Host "No hay procesos que consuman más de 100 MB de memoria."
    }
}

# Bucle para el menú principal
do {
    Clear-Host  # Limpiar pantalla cada vez que se muestra el menú
    Mostrar-Menu
    $opcion = Read-Host "Selecciona una opción"

    switch ($opcion) {
        1 {
            Mostrar-Programas-Inicio
        }
        2 {
            Guardar-Procesos-CSV
        }
        3 {
            Detener-Proceso-Alto-CPU
        }
        4 {
            Detener-Procesos-Alta-Memoria
        }
        5 {
            Write-Host "Saliendo..."
        }
        default {
            Write-Host "Opción no válida. Por favor, selecciona una opción válida."
        }
    }

    # Esperar para volver al menú
    if ($opcion -ne 5) {
        Pause
    }
} while ($opcion -ne 5)
