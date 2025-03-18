cad = str(input("Selecciona una cadena: "))
dic = {}

for car in cad:
    if car in dic:
        dic[car] += 1
    else:
        dic[car]= 1
for campo, valor in dic.items():
    print(campo, "->", valor)
