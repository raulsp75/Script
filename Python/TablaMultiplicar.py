num=int(input("Selecciona el número que quieras la tabla de multiplicar: "))

for i in range(1, 11):
    mult=(i * num)
    print(f"{num}x{i}={mult}")
