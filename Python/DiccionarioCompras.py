dic={"manzana": 1, "platano": 2, 
     "sandia": 1.50, "melocoton":1.25}

op="si"
while op == "si":
    fruta=str(input("Selecciona la fruta: "))
    cant=int(input("Selecciona la cantidad: "))
    if fruta in dic:
          valor= dic[fruta]
          precio=(valor * cant)
          print(f"El precio de {cant} de {fruta} es {precio}€")
    else:
         print("Esa fruta no está en la lista")
    op=str(input("Quieres volver a hacer una consulta? si no "))
