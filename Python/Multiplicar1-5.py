#Tabla de multiplicar del 1 al 5
for num in range(1,6):
    print(f"La tabla de multiplicar del {num}:")
    for i in range(1, 11):
        mult=(i * num)
        print(f"{num}x{i}={mult}")
