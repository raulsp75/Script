#Ingresamos el numero de alumnos
alumnos = int(input("Ingrese la cantidad de alumnos: "))
#Comenzamos el condicional dependiendo del numero de alunmos, pues se pagará cierta cantidad de dinero.
if alumnos >= 100:
  print(f"el pago de la agencia es de {alumnos*65} euros y cada alumno debe pagar 65 euros")
elif alumnos < 100 and alumnos >= 50:
  print(f"El pago a la agencia es de {alumnos*70} euros y cada alumno debe de pagar 70 euros")
elif alumnos < 50 and alumnos >=30:
  print(f"El pago a la agencia es de {alumnos*95} euros y cada alumno debe de pagar 95 euros")
else:
  print(f"El coste de la guagua es de 4000 euros y cada alumno debe pagar {int(4000/alumnos)} euros")
