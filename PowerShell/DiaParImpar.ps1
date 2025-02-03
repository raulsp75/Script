#Calcular el número de días pares e impares que hay en un año bisiesto.

$par = 0
$impar = 0
 
1..366 | foreach{
    $dia = ([datetime]"01/01/2025 00:00").AddDays($_).Day
    if ($dia %2)
    {
        $impar++
    }
    else
    {
        $par++
    }
}
 
"Días pares: " + $par.ToString()
"Días impares: " + $impar.ToString()
