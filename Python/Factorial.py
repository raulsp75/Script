#Factorial
num=int(input("Selecciona un número del que quieras el factorial: "))
fac=1
for i in range(1, num+1):
    fac=fac * i
    i= i + 1
print(f"El numero factorial de {num} es {fac}")
