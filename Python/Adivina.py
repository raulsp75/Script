import random

numero_secreto = random.randint(1, 100)
intentos = 10

# Pedimos al usuario y número y creamos las posibilidades
print("Adivina el número entre 1 y 100. Tienes 10 intentos.")

while intentos > 0:
    numero = int(input("Introduce un número: "))
    
    if numero == numero_secreto:
        print(f"¡Felicidades! Adivinaste el número en {10 - intentos + 1} intentos.")
        break
    elif numero < numero_secreto:
        print("El número secreto es mayor.")
    else:
        print("El número secreto es menor.")

    intentos -= 1

if intentos == 0:
    print(f"Te quedaste sin intentos. El número era {numero_secreto}.")
