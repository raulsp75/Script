#================================================================================
#Ejercicio1
vel1 = float(input("¿Qué velocidad tiene la primera moto? (km/h)"))
vel2 = float(input("¿Qué velocidad tiene la segunda moto? (km/h)"))
dis = float(input("¿A qué distancia se encuentra una de la otra? (km)"))

def calculo(vel1,vel2,dis):
 if vel1 >= vel2: #En caso de que la moto 1 vaya más rápido que la moto 2
  print("Las motos no se llegarán a alcanzar")
 else: #De no ser así
  t = dis/(vel2-vel1)
  return (f"La segunda moto alcanzará a la primera en {t} horas")
#Llamamos a la función
calculo(vel1,vel2,dis)

#================================================================================
#Ejercicio 2
alum = int(input("Cuantos alumnos son?: "))

def viaje(alum):
  if alum >= 100:
    cost = 65
  elif alum >= 50:
    cost = 70
  elif alum >= 30:
    cost = 95
  else:
    cost = 4000/alum
  print(f"Si hay {alum} alumnos el viaje costará {cost:.2f}€.")
viaje(alum)

#================================================================================
#Ejercicio 3
import random
num = int(input("Selecciona un número: "))
numAle = random.randint(1, 100)
intentos = 1

def ale(num, numAle, intentos):
  while intentos < 10:
    if num == numAle:
      print(f"El número {num} es el correcto. En un total de {intentos}. ")
      break
    elif num < numAle:
      print("El numero a adivinar es mayor que el que has introducido. ")
      num = int(input("Selecciona un número: "))
    else:
      print("El numero a adivinar es menor que el que has introducido. ")
      num = int(input("Selecciona un número: "))
    intentos = (intentos + 1)
  if intentos == 10:
    print("Ya no tienes mas intentos crack")
ale(num, numAle, intentos)

#================================================================================
#Ejercicio 4
frase = str(input("Pasame una frase con espacios: "))
palabras = frase.split()
pala = len(palabras)
print(f"El número de palabras de la frase es {pala}")

#================================================================================
#Ejercicio 5
TodNota = []
Suma = 0
for i in range(0,5):
  nota = float(input("Dame una nota: "))
  if nota >=0 and nota <= 10:
    TodNota.append(nota)
    Suma = Suma + nota
  else:
    print("Eres flautista. Vuelve a empezar")
    break
NotMedia = (Suma/5)
NotMax = (max(TodNota))
NotMin = (min(TodNota))

print(f"Aquí están todas las notas: {TodNota} ")
print(f"Esta es la nota media {NotMedia} ")
print(f"Esta es la nota máxima {NotMax} ")
print(f"Esta es la nota minima {NotMin} ")

#================================================================================
#Ejercicio 6
import numpy as np

def crear_tabla_diagonal(size=5):
    # Crear una matriz de ceros
    tabla = np.zeros((size, size), dtype=int)

    # Llenar las diagonales con 1
    np.fill_diagonal(tabla, 1)
    np.fill_diagonal(np.fliplr(tabla), 1)

    return tabla

# Crear la tabla
tabla_diagonal = crear_tabla_diagonal()

# Mostrar la tabla
for fila in tabla_diagonal:
    print(" ".join(map(str, fila)))

#================================================================================
#Ejercicio 7
dicci = {}
num = int(input("Dame un número: "))
for i in range(1, num+1):
  var = (i * i)
  dicci[i] = var
print(dicci)

#================================================================================
#Ejercicio 8
# Definimos la agenda como un diccionario vacío
agenda = {}

def mostrar_menu():
    print("\n--- Agenda Telefónica ---")
    print("1. Añadir/Modificar contacto")
    print("2. Buscar contacto")
    print("3. Borrar contacto")
    print("4. Listar contactos")
    print("5. Salir")

def añadir_modificar_contacto():
    nombre = input("Introduce el nombre del contacto: ")
    if nombre in agenda:
        print(f"El número actual de {nombre} es: {agenda[nombre]}")
        modificar = input("¿Deseas modificarlo? (s/n): ").lower()
        if modificar == 's':
            telefono = input("Introduce el nuevo número de teléfono: ")
            agenda[nombre] = telefono
            print("Contacto modificado correctamente.")
    else:
        telefono = input("Introduce el número de teléfono: ")
        agenda[nombre] = telefono
        print("Contacto añadido correctamente.")

def buscar_contacto():
    cadena = input("Introduce la cadena de búsqueda: ")
    encontrados = {nombre: telefono for nombre, telefono in agenda.items() if nombre.startswith(cadena)}
    if encontrados:
        print("\nContactos encontrados:")
        for nombre, telefono in encontrados.items():
            print(f"{nombre}: {telefono}")
    else:
        print("No se encontraron contactos que coincidan con la búsqueda.")

def borrar_contacto():
    nombre = input("Introduce el nombre del contacto a borrar: ")
    if nombre in agenda:
        confirmar = input(f"¿Estás seguro de borrar a {nombre}? (s/n): ").lower()
        if confirmar == 's':
            del agenda[nombre]
            print("Contacto borrado correctamente.")
    else:
        print("El contacto no existe en la agenda.")

def listar_contactos():
    if agenda:
        print("\nLista de contactos:")
        for nombre, telefono in agenda.items():
            print(f"{nombre}: {telefono}")
    else:
        print("La agenda está vacía.")

def main():
    while True:
        mostrar_menu()
        opcion = input("Selecciona una opción (1-5): ")
        
        if opcion == '1':
            añadir_modificar_contacto()
        elif opcion == '2':
            buscar_contacto()
        elif opcion == '3':
            borrar_contacto()
        elif opcion == '4':
            listar_contactos()
        elif opcion == '5':
            print("Saliendo de la agenda...")
            break
        else:
            print("Opción no válida. Inténtalo de nuevo.")

if __name__ == "__main__":
    main()

#================================================================================
#Ejercicio 9
def leer_fecha():
    """Lee el día, mes y año desde el teclado."""
    dia = int(input("Introduce el día: "))
    mes = int(input("Introduce el mes: "))
    año = int(input("Introduce el año: "))
    return dia, mes, año

def dias_del_mes(mes, año):
    """Devuelve el número de días de un mes en un año dado."""
    if mes in [4, 6, 9, 11]:  # Abril, junio, septiembre, noviembre
        return 30
    elif mes == 2:  # Febrero
        return 29 if es_bisiesto(año) else 28
    else:  # Enero, marzo, mayo, julio, agosto, octubre, diciembre
        return 31

def es_bisiesto(año):
    """Determina si un año es bisiesto."""
    return (año % 4 == 0 and año % 100 != 0) or (año % 400 == 0)

def calcular_dia_juliano(dia, mes, año):
    """Calcula el día juliano de una fecha dada."""
    dia_juliano = sum(dias_del_mes(m, año) for m in range(1, mes)) + dia
    return dia_juliano

# Programa principal
dia, mes, año = leer_fecha()
dia_juliano = calcular_dia_juliano(dia, mes, año)

print(f"El día juliano de la fecha {dia}/{mes}/{año} es: {dia_juliano}")

#================================================================================
#Ejercicio 10
def CalcularMCD(a, b):
    """Calcula el MCD usando el método de Euclides."""
    while b != 0:
        a, b = b, a % b
    return a

# Pedir dos números al usuario
num1 = int(input("Introduce el primer número: "))
num2 = int(input("Introduce el segundo número: "))

# Calcular y mostrar el MCD
print(f"El MCD de {num1} y {num2} es: {CalcularMCD(num1, num2)}")
