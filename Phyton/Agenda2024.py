def mostrar_menu():
    print("============================")    
    print("AGENDA TELEFÓNICA")
    print("1. Añadir/Modificar contacto")
    print("2. Buscar contacto")
    print("3. Borrar contacto")
    print("4. Listar contactos")
    print("5. Salir")

def agregar_modificar(agenda, nombre, telefono):
    agenda[nombre] = telefono

def buscar(agenda, cadena):
    return {nombre: telefono for nombre, telefono in agenda.items() if nombre.startswith(cadena)}

def borrar(agenda, nombre):
    if nombre in agenda:
        del agenda[nombre]
        return True
    return False

def listar(agenda):
    return agenda

def ejecutar_agenda():
    agenda = {}  # Diccionario para almacenar contactos
    opcion = None  # Inicializar la opción

    while opcion != "5":  # Se repite hasta que el usuario elija salir
        mostrar_menu()
        opcion = input("Seleccione una opción (1-5): ")

        if opcion == "1":  # Añadir/Modificar
            nombre = input("Ingrese el nombre: ").strip().capitalize()
            if nombre in agenda:
                print(f"El número actual de {nombre} es: {agenda[nombre]}")
                modificar = input("¿Desea modificarlo? (s/n): ").strip().lower()
                if modificar == "s":
                    telefono = input("Ingrese el nuevo número: ").strip()
                    agregar_modificar(agenda, nombre, telefono)
            else:
                telefono = input("Ingrese el número: ").strip()
                agregar_modificar(agenda, nombre, telefono)

        elif opcion == "2":  # Buscar
            cadena = input("Ingrese el inicio del nombre a buscar: ").strip().capitalize()
            resultados = buscar(agenda, cadena)
            if resultados:
                for nombre, telefono in resultados.items():
                    print(f"{nombre}: {telefono}")
            else:
                print("No se encontraron contactos.")

        elif opcion == "3":  # Borrar
            nombre = input("Ingrese el nombre a borrar: ").strip().capitalize()
            if borrar(agenda, nombre):
                print(f"{nombre} ha sido eliminado.")
            else:
                print("El contacto no existe.")

        elif opcion == "4":  # Listar
            contactos = listar(agenda)
            if contactos:
                for nombre, telefono in contactos.items():
                    print(f"{nombre}: {telefono}")
            else:
                print("La agenda está vacía.")

        elif opcion == "5":  # Salir
            print("Saliendo de la agenda.")

        else:
            print("Opción no válida.")

# Llamar a la función para ejecutar la agenda
ejecutar_agenda()
