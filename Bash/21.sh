#!/bin/bash

# Definimos los repositorios
REPOS=("Fotografía" "Dibujo" "Imágenes")
VALID_EXT=("jpg" "png" "gif")
LOG_FILE="descartados.log"

# Función para verificar y corregir archivos
detect_and_fix_files() {
    local repo=$1
    for file in "$repo"/*; do
        if [[ -f "$file" ]]; then
            local actual_format=$(file -b --mime-type "$file" | cut -d'/' -f2)
            local extension="${file##*.}"
            local owner=$(stat -c "%U" "$file")
            local group=$(stat -c "%G" "$file")
            local filename=$(basename -- "$file")
            local current_date=$(date +%d.%m.%Y)
            
            if [[ ! " ${VALID_EXT[@]} " =~ " $extension " ]]; then
                if [[ " ${VALID_EXT[@]} " =~ " $actual_format " ]]; then
                    mv "$file" "${file%.*}.$actual_format"
                else
                    echo "$owner;$group;$current_date; $filename" >> "$LOG_FILE"
                    rm "$file"
                fi
            fi
        fi
    done
}

# Si hay un parámetro, verificar archivos eliminados por usuario
if [[ $# -eq 1 ]]; then
    user=$1
    if [[ -f "$LOG_FILE" ]]; then
        count=$(grep -c "^$user;" "$LOG_FILE")
        echo "El usuario $user ha tenido $count archivos eliminados."
    else
        echo "No hay registros de archivos eliminados."
    fi
    exit 0
fi

# Ejecutar la verificación en cada repositorio
for repo in "${REPOS[@]}"; do
    if [[ -d "$repo" ]]; then
        detect_and_fix_files "$repo"
    fi
done

echo "Proceso completado."
