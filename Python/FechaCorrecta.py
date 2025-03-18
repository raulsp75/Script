#Fecha correcta
dia=int(input("Selecciona el dia: "))
mes=int(input("Selecciona el mes: "))
ano=int(input("Selecciona el año: "))

if dia <= 31 and mes <= 12 and ano <= 2025:
    print("El año ha sido correcto")
else:
    print("Alguno de los valores ha sido incorrecto")
