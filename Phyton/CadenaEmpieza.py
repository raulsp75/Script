cadena=input("Selecciona una cadena: ")
subca=input("Selecciona una subcadena a ver si está: ")

if cadena.startswith(subca):
    print(f"La cadena empieza por {subca}")
else:
    print(f"La cadena no empieza por {subca}")
