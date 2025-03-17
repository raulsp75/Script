#Se pide desinstalar los programas de un archivo de texto
# Ruta del archivo txt
$ruta = "C:\Users\Administrador\Documents\Scripts\Programas.txt"

# Lee el contenido de Programas.txt
$programas = Get-Content -Path $ruta

foreach ($programa in $programas) {

    # Busca el archivo de desinstalacion filtrando por el nombre del programa
    $instalado = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object { $_.DisplayName -match $programa }
    
    # Comprueba si la variable tiene valor 
    if ($instalado) {
        # Comprueba si existe el uninstallString en la variable
        if ($instalado.UninstallString) {
            
            # Almacena el comando de desinstalacion en una variable
            $desinstala = "$($instalado.UninstallString)"

            #Ejecuta el comando desde el cmd y el wait hace que espero a desinstalar para continuar con el script
            Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$desinstala`"" -Wait
            Write-Output "$programa ha sido desinstalado."
        } else {
            Write-Output "No se encontró una cadena de desinstalación para $programa."
        }
    }
}
