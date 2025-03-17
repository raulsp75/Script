import numpy as np

def crear_tabla_diagonal(size=5):
    # Crear una matriz de ceros
    tabla = np.zeros((size, size), dtype=int)
    
    # Llenar las diagonales con 1
    np.fill_diagonal(tabla, 1)
    np.fill_diagonal(np.fliplr(tabla), 1)
    
    return tabla

# Crear la tabla
tabla_diagonal = crear_tabla_diagonal()

# Mostrar la tabla
for fila in tabla_diagonal:
    print(" ".join(map(str, fila)))
