import random
lista=[]

for num in range(0,10):
    lista.append(random.randint(0,100))
    print(lista[num])
    cuadrado=(lista[num] * lista[num])
    cubo=(cuadrado * lista[num])
    print(f"El cuadrado es: {cuadrado}")
    print(f"El cubo es: {cubo}")
