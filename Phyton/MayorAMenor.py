#Ordenar de mayor a menor
nu1=int(input("Selecciona el primer número: "))
nu2=int(input("Selecciona el segundo número: "))
nu3=int(input("Selecciona el tercer número: "))

array=[nu1,nu2,nu3]
array.sort(reverse=True)
print(array)
