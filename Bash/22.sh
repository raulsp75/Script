#!/bin/bash

# Verificar que se pasa un único parámetro
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <archivo_bajas.txt>"
    exit 1
fi

# Verificar que el parámetro es un archivo existente
if [ ! -f "$1" ]; then
    echo "Error: El archivo $1 no existe."
    exit 1
fi

BAJAS_ERROR_LOG="bajaserror.log"
BAJAS_LOG="bajas.log"
HOME_PROYECTO="/home/proyecto"
TRABAJO_DIR="trabajo"

# Procesar cada línea del archivo de bajas
while IFS=: read -r nombre apellidos login; do
    if id "$login" &>/dev/null; then
        # Crear carpeta de respaldo dentro de /home/proyecto/
        DESTINO="$HOME_PROYECTO/$login"
        mkdir -p "$DESTINO"
        
        # Mover solo los ficheros del directorio 'trabajo'
        HOME_USER="/home/$login"
        if [ -d "$HOME_USER/$TRABAJO_DIR" ]; then
            mv "$HOME_USER/$TRABAJO_DIR"/* "$DESTINO" 2>/dev/null
        fi
        
        # Cambiar propietario de los ficheros a root
        chown -R root:root "$DESTINO"
        
        # Registrar en bajas.log
        echo "$(date +%d/%m/%Y-%H:%M:%S)-$login-$DESTINO" >> "$BAJAS_LOG"
        ls "$DESTINO" >> "$BAJAS_LOG"
        echo "Total de ficheros movidos: $(ls -1 "$DESTINO" | wc -l)" >> "$BAJAS_LOG"
        
        # Eliminar usuario y su home
        userdel -r "$login"
    else
        # Usuario no existe, registrar error
        echo "$(date +%d/%m/%Y-%H:%M:%S)-$login-$nombre-$apellidos-ERROR:login no existe en el sistema" >> "$BAJAS_ERROR_LOG"
    fi
done < "$1"

echo "Proceso de baja completado."
