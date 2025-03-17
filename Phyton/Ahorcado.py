# Convierte la palabra en una lista de caracteres para facilitar la manipulación
word = list("hipoglucido")  

# Crea una lista vacía donde se almacenará la versión oculta de la palabra
hidden = list()

# Llena `hidden` con guiones bajos ("_") para ocultar las letras de la palabra
for char in word:
    hidden.append("_")

# Define el número máximo de intentos permitidos antes de perder
maxtries = 5

# Contador de intentos fallidos
tries = 0

# Variable para controlar si el juego ha terminado
isgameover = False

# Variable donde se almacenará la letra ingresada por el usuario
guess = ""

# Contador de aciertos (cantidad de letras descubiertas)
hits = 0

# Bucle principal del juego: se ejecuta hasta que el jugador gane o pierda
while isgameover == False:

    # Muestra los intentos restantes y la palabra oculta hasta el momento
    print("Te quedan", maxtries - tries, "intentos")
    print(hidden)

    # Pide al usuario que ingrese una letra
    guess = input("Introduce una letra ")

    # Verifica si la letra ingresada está en la palabra
 if guess in word:
        print("La letra", guess ,"está en la palabra")
        
        # Recorre la palabra para encontrar todas las coincidencias
        for i in range(len(word)):
            if word[i] == guess:
                hidden[i] = word[i]  # Revela la letra en la lista `hidden`
                word[i] = "_"  # Reemplaza la letra en `word` con "_" (⚠️ Esto podría ser un error)
                hits += 1  # Aumenta el número de aciertos
    else:
        print("La letra", guess, "no está en la palabra")
        tries = tries + 1  # Incrementa el contador de intentos fallidos

    # Verifica si el jugador ha agotado los intentos
    if tries == maxtries:
        print("Has perdido")
        isgameover = True  # Finaliza el juego

    # Verifica si se han adivinado todas las letras
    if hits == len(word):
        print("Has ganado")
        print(hidden)  # Muestra la palabra completa
        isgameover = True  # Finaliza el juego
