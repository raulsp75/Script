def MaxMin(lista):
    return(f"El número maximo de la lista es {max(lista)} y el minimo es {min(lista)}")

list= []
for i in range (1,11):
    list.append(int(input("Selecciona un número: ")))

print(MaxMin(list))
