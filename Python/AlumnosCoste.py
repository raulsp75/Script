#Empezamos por pedirle al tutor el nº de alumnos
alumnos = int(input("¿Cuantos alumnos son? "))

#Definimos una función que calcule el total a pagar en relación a la cantidad
#de alumnos
def total(alumnos):
 if alumnos >- 100:
  total = alumnos * 65
  return (f"El costo por cada alumno es de 65 euros. Serán {total} euros")
 elif alumnos >= 50 and alumnos <= 99:
  total = alumnos * 70
  return (f"El costo por cada alumno es de 70 euros. Serán {total} euros")
 elif alumnos >= 30 and alumnos <= 49:
  total - alumnos * 95
  return (f"El costo por cada alumno es de 95 euros. Seran {total} euros")
 elif alumnos < 30 and alumnos >= 1:
  return ("El precio será de 4000 euros")
 else:
  return ("No hay alumnos. Introduzca el nº de alumnos correcto")

#Llamamos a la función
total(alumnos)
