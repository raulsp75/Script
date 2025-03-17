# Importante: Este script debe ejecutarse en un entorno con privilegios de administrador.

function CalcularFactorial {
    param([int]$numero)
    if ($numero -lt 0) {
        Write-Host "El número debe ser positivo."
        return
    }
    $resultado = 1
    for ($i = 1; $i -le $numero; $i++) {
        $resultado *= $i
    }
    Write-Host "La factorial de $numero es $resultado"
}

function VerificarBisiesto {
    param([int]$anio)
    if (($anio % 4 -eq 0 -and $anio % 100 -ne 0) -or ($anio % 400 -eq 0)) {
        Write-Host "$anio es un año bisiesto."
    } else {
        Write-Host "$anio no es un año bisiesto."
    }
}

function ContarDiasParesImpares {
    param([int]$anio)
    if (($anio % 4 -eq 0 -and $anio % 100 -ne 0) -or ($anio % 400 -eq 0)) {
        $diasEnAnio = 366
    } else {
        $diasEnAnio = 365
    }
    $diasPares = 0
    $diasImpares = 0
    for ($i = 1; $i -le $diasEnAnio; $i++) {
        if ($i % 2 -eq 0) {
            $diasPares++
        } else {
            $diasImpares++
        }
    }
    Write-Host "En el año $anio hay $diasPares días pares y $diasImpares días impares."
}

function CrearCarpetaConFecha {
    param([string]$rutaBase)
    $fecha = Get-Date -Format "yyyyMMdd"
    $nuevaCarpeta = Join-Path -Path $rutaBase -ChildPath $fecha
    New-Item -Path $nuevaCarpeta -ItemType Directory | Out-Null
    Write-Host "Carpeta creada: $nuevaCarpeta"
}

function Menu {
    Write-Host "=== MENÚ PRINCIPAL ==="
    Write-Host "1. Calcular Factorial"
    Write-Host "2. Verificar Año Bisiesto"
    Write-Host "3. Contar Días Pares e Impares"
    Write-Host "4. Crear Carpeta con Fecha"
    Write-Host "5. Salir"

    $opcion = Read-Host "Seleccione una opción"

    switch ($opcion) {
        1 {
            $numero = Read-Host "Ingrese un número"
            CalcularFactorial -numero $numero
        }
        2 {
            $anio = Read-Host "Ingrese un año"
            VerificarBisiesto -anio $anio
        }
        3 {
            $anio = Read-Host "Ingrese un año"
            ContarDiasParesImpares -anio $anio
        }
        4 {
            $rutaBase = Read-Host "Ingrese la ruta base"
            CrearCarpetaConFecha -rutaBase $rutaBase
        }
        5 {
            Write-Host "Saliendo..."
            return
        }
        default {
            Write-Host "Opción no válida."
        }
    }

    # Volver al menú si no se eligió salir
    if ($opcion -ne 5) {
        Menu
    }
}

# Iniciar el menú
Menu
