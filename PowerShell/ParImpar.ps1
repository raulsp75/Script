# Inicializamos los contadores
$Pares = 0
$Impares = 0

# Iteramos por todos los días del año
0..365 | ForEach-Object {
    $dia = ([datetime]"01/01/2025 00:00").AddDays($_).Day
    
    if ($dia % 2) {
        $Impares++
    } else {
        $Pares++
    }
}

# Mostramos los resultados
Write-Host "Días pares: $Pares"
Write-Host "Días impares: $Impares"
