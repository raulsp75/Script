#Se pide desinstalar todas las aplicaciones que estén en el archivo programas.txt mediante un script.

#!/bin/bash

#Declaramos las variables de color
AM='\033[1;33m'
NColor='\033[0m'

# Verifica si el archivo programas.txt existe
if [ ! -f "programas.txt" ]; then
  echo -e "${AM}No existe el archivo programas.txt${NColor}"
  exit 1
fi

# Leer el archivo línea por línea
while IFS= read -r programa; do
  if [ -n "$programa" ]; then
    #Desinstala el programa
    sudo apt remove -y "$programa"
    # Comprobar si se desinstaló correctamente
    if [ $? -eq 0 ]; then
      echo -e "${AM}El programa '$programa' se ha eliminado correctamente.${NColor}"
    else
      echo -e "${AM}El programa '$programa' sigue instalado${NColor}"
    fi
  fi
done < "programas.txt"

echo -e "${AM}Se han desinstalado los programas${Ncolor}"
