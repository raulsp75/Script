import math
cal1=float(input("Selecciona la nota del primer parcial: "))
cal2=float(input("Selecciona la nota del segundo parcial: "))
cal3=float(input("Selecciona la nota del tercer parcial: "))
exaFi=float(input("Selecciona la nota del examen final: "))
traFi=float(input("Selecciona la nota del trabajo final: "))

CalPar= ((cal1 + cal2 + cal3) / 3)
CalPar= (CalPar * 0.55)
exaFi= (exaFi * 0.3)
traFi= (traFi * 0.15)

CalFin= traFi + exaFi + CalPar
CalFin=round(CalFin, 1)
print("La nota final es: ", CalFin )
