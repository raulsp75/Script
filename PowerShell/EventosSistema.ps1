#Menú que muestre los eventos del sistema y hasta que no se pulse 0 no salga

# Menu
function Menu {
     Clear-Host
     Write-Host "0. Salir"
     Write-Host "1. Eventos del sistema de errores"
     Write-Host "2. Eventos del sistema de advertencias"
     Write-Host "3. Eventos del sistema de información"
}

#Eventos Error
function Error {
    Get-WinEvent -LogName System | Where-Object { $_.LevelDisplayName -eq 'Error' } | Select-Object -Last 12
}

#Eventos Advertencia
function Advertencia {
    Get-WinEvent -LogName System | Where-Object { $_.LevelDisplayName -eq 'Advertencia'} | Select-Object -Last 12
}

#Eventos Informacion
function Infomacion {
    Get-WinEvent -LogName System | Where-Object { $_.LevelDisplayName -eq 'Información'} | Select-Object -Last 12
}

#Bucle del menu
do {
    Menu
    $opcion = Read-host "Seleccione una ópcion"
    
    switch($opcion) {
    0 {
        Write-Host "Saliendo del Menu"
    }
    1 {
        Error 
    }
    2 {
        Advertencia 
    }
    3 {
        Infomacion 
    }
    default {
        Write-Host "Opcion no valida. Selecciona otra."
        Read-Host -Prompt "Presiona Enter para continuar"
    }
}
if ($opcion -ne 0) {
    Pause
    }
 } while ($opcion -ne 0) 
