#Enunciado
#Crear un script en bash que recibe como parámetros el año, el mes y el día y devuelva por pantalla de manera clara y legible el número de registros de errores según los siguientes niveles de severidad: 
#"emergente", "alerta", "crítico", "error", "advertencia", "noticia", "información" y "depuración" que han sucedido desde la fecha pasada por parámetro hasta la fecha actual. 
#Debe de comprobarse la validez de los datos y si se pasa una fecha posterior a la actual, devolviendo un mensaje explicativo al usuario.

# Función para comprobar si una fecha es válida
function validar_fecha() {
    date -d "$1" "+%Y-%m-%d" > /dev/null 2>&1
    return $?
}

# Comprobar que se pasaron 3 argumentos (año, mes, día)
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 año mes día"
    exit 1
fi

# Asignar los parámetros a variables
anio=$1
mes=$2
dia=$3

# Construir la fecha ingresada
fecha_iniciada="$anio-$mes-$dia"

# Comprobar si la fecha es válida
if ! validar_fecha "$fecha_iniciada"; then
    echo "Fecha inválida. Por favor, introduzca una fecha válida en el formato: Año Mes Día"
    exit 1
fi

# Obtener la fecha actual
fecha_actual=$(date "+%Y-%m-%d")

# Comparar las fechas. Si la fecha ingresada es mayor que la fecha actual, mostrar error
if [[ "$fecha_iniciada" > "$fecha_actual" ]]; then
    echo "Error: la fecha introducida ($fecha_iniciada) es posterior a la fecha actual ($fecha_actual)."
    exit 1
fi
# Archivo de logs del sistema (puede variar según la distribución, por ejemplo: /var/log/syslog o /var/log/messages)
LOG_FILE="/var/log/syslog"

# Verificar que el archivo de logs exista
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: el archivo de logs del sistema ($LOG_FILE) no existe."
    exit 1
fi

# Filtrar los registros desde la fecha ingresada y contar por severidad
echo "Contando los registros de errores desde $fecha_iniciada hasta $fecha_actual:"

# Mapear los niveles de severidad al formato de syslog
declare -A severidades
severidades["emergente"]="emerg"
severidades["alerta"]="alert"
severidades["crítico"]="crit"
severidades["error"]="err"
severidades["advertencia"]="warning"
severidades["noticia"]="notice"
severidades["información"]="info"
severidades["depuración"]="debug"

# Contar las ocurrencias por cada nivel de severidad
for nivel in "${!severidades[@]}"; do
    conteo=$(grep -i -E "${severidades[$nivel]}" "$LOG_FILE" | awk -v fecha="$fecha_iniciada" '$0 >= fecha' | wc -l)
    echo "$nivel: $conteo"
done
