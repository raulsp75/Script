#Escribir un programa en PowerShell que permita a un usuario realizar una reserva en un restaurante. El script deberá preguntar el número de personas, 
#la fecha y hora de la reserva, y asignar una mesa disponible. Al final, mostrará la confirmación con todos los datos de la reserva. 

# Definimos un array con las mesas disponibles
$mesasDisponibles = @("Mesa 1", "Mesa 2", "Mesa 3", "Mesa 4", "Mesa 5")

# Solicitar información al usuario
$nombreCliente = Read-Host "Ingrese su nombre"
$numPersonas = Read-Host "Ingrese el número de personas para la reserva"
$fechaReserva = Read-Host "Ingrese la fecha de la reserva (Formato: DD/MM/YYYY)"
$horaReserva = Read-Host "Ingrese la hora de la reserva (Formato: HH:MM)"

# Mostrar las mesas disponibles
Write-Host "Mesas disponibles:"
foreach ($mesa in $mesasDisponibles) {
    Write-Host $mesa
}

# Solicitar la elección de la mesa
$mesaSeleccionada = Read-Host "Seleccione una mesa (Ejemplo: Mesa 1, Mesa 2, etc.)"

# Validar si la mesa seleccionada está en la lista de disponibles
if ($mesasDisponibles -contains $mesaSeleccionada) {
    Write-Host "\n--- Confirmación de Reserva ---"
    Write-Host "Cliente: $nombreCliente"
    Write-Host "Número de personas: $numPersonas"
    Write-Host "Fecha de reserva: $fechaReserva"
    Write-Host "Hora de reserva: $horaReserva"
    Write-Host "Mesa asignada: $mesaSeleccionada"
    Write-Host "\n¡Reserva confirmada!"
} else {
    Write-Host "\nLa mesa seleccionada no está disponible o no existe. Por favor, intente de nuevo."
}
