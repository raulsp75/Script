import random

# Crear una tabla de 5x5 con valores enteros aleatorios entre 1 y 100
tabla = [[random.randint(1, 100) for _ in range(5)] for _ in range(5)]

# Imprimir la tabla
print("Tabla generada:")
for fila in tabla:
    print(fila)

# Sumar los elementos de cada fila
suma_filas = [sum(fila) for fila in tabla]
print("\nSuma de cada fila:", suma_filas)

# Sumar los elementos de cada columna
suma_columnas = [sum(tabla[fila][col] for fila in range(5)) for col in range(5)]
print("Suma de cada columna:", suma_columnas)
