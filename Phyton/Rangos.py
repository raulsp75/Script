#Utilizando rangos, suma el valor de todos los números pares desde el 2 (inclusive) hasta el 100

suma = 0
for i in range(2,101,2):
    suma += i
print("La suma de todos los números pares del 2 al 100 es:", suma)
