#Se pide un script que recorra todos los archivos en el directorio /var/log, filtre las líneas que contienen errores 
#(con las palabras clave "error" o "fail"), y genere un nuevo archivo con los resultados.

#!/bin/bash

for archivos in /var/log/*
do
        #Comprobamos que es un archivo y comprobamos las palabras error y fail y las guardamos en la variable errores
        if [ -f "$archivos" ]; then
                errores=$(grep -iE "error|fail" "$archivos")

        if [ ! -z "$errores" ]; then
                #Añadimos el nombre del archivo de error/fail
                echo "Errores en el archivo: $archivos" >> "Error_log.txt"
                #Añadir los errores/fail
                echo "$errores" >> "Error_log.txt"
                #Añadir un espacio entre registros
                echo "" >> "Error_log.txt"
                fi
        fi
done
echo "Los errores están en el archivo Error_log.txt"
