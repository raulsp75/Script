# Script para calcular la edad en años, meses y días

# Solicitar la fecha de nacimiento del usuario
$fechaNacimiento = Read-Host "Ingrese su fecha de nacimiento (Formato: DD/MM/YYYY)"

# Convertir la entrada a un objeto de fecha
$fechaNacimiento = [datetime]::ParseExact($fechaNacimiento, 'dd/MM/yyyy', $null)
$fechaActual = Get-Date

# Calcular la diferencia de años, meses y días
$edadAnios = $fechaActual.Year - $fechaNacimiento.Year
$edadMeses = $fechaActual.Month - $fechaNacimiento.Month
$edadDias = $fechaActual.Day - $fechaNacimiento.Day

# Ajustar si el mes o día son negativos
if ($edadDias -lt 0) {
    $edadMeses--
    $diasEnMesPrevio = (Get-Date -Year $fechaActual.Year -Month $fechaActual.Month -Day 1).AddDays(-1).Day
    $edadDias += $diasEnMesPrevio
}

if ($edadMeses -lt 0) {
    $edadAnios--
    $edadMeses += 12
}

# Mostrar resultado
Write-Host "Usted tiene $edadAnios años, $edadMeses meses y $edadDias días."
