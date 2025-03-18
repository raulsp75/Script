# Pedir 5 notas al usuario
notas = [float(input(f"Introduce la nota {i + 1} (0-10): ")) for i in range(5)]

# Calcular la media, la nota más alta y la más baja
nota_media = sum(notas) / len(notas)
nota_maxima = max(notas)
nota_minima = min(notas)

# Mostrar resultados
print("\nNotas ingresadas:", notas)
print(f"Nota media: {nota_media:.2f}")
print(f"Nota más alta: {nota_maxima}")
print(f"Nota más baja: {nota_minima}")
