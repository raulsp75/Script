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
