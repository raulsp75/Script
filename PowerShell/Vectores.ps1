
﻿$numeros = 4,6,7.5,8  # Define un array de números con los valores 4, 6, 7.5 y 8
$nombres = "chuck", "jackie", "charles"  # Define un array de nombres con los valores "chuck", "jackie" y "charles"

Function Sumatorio([double[]]$numeros) {  # Define una función llamada Sumatorio que toma un array de números de tipo double como parámetro
    $total=0  # Inicializa una variable $total con el valor 0
    foreach ($numero in $numeros) {  # Inicia un bucle foreach que itera sobre cada número en el array $numeros
        $total += $numero  # Suma el valor de $numero a $total en cada iteración
    }
    return $total  # Devuelve el valor total de la suma de los números
}

Write-Host "El total es $(Sumatorio $numeros)"  # Llama a la función Sumatorio con el array $numeros y muestra el resultado en la consola

Write-Host "Vamos a saludar a $($nombres.Length) personas"  # Muestra en la consola el número de personas en el array $nombres
foreach ($nombre in $nombres) {  # Inicia un bucle foreach que itera sobre cada nombre en el array $nombres

    if ($nombre -match "^c.*") {  # Comprueba si el nombre comienza con la letra "c" utilizando una expresión regular
        Write-Host "Hola $nombre!"  # Si el nombre comienza con "c", muestra un saludo en la consola
    }

}

Write-Host "El 2º elemento del array es" $nombres[1]  # Muestra en la consola el segundo elemento del array $nombres (índice 1)
[1]
