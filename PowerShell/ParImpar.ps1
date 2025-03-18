$par = 0
$impar = 0

0 .. 364 | % {
    $dia = ([datetime]"01/01/2021 00:00").AddDays($_).Day
    if ($dia %2)
    {
     $impar++
    }
     else
    {
     $par++
     }
}
"Dias pares: " + $par. ToString()
"Dias impares: " + $impar. ToString()
