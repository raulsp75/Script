notaBa=11
notaAL= -1
notaTO= 0
for num in range(1,6):
    nota=int(input(f"Selecciona la nota del alumno{num}: "))
    if nota > 10 or nota < 0:
        print("La nota debe estar entre 0 y 10")
        break
    if nota < notaBa:
        notaBa = nota
    if nota > notaAL:
        notaAL = nota
    notaTO= nota + notaTO
    if num == 5:
        notaMe= notaTO / 5
        print(f"La nota media es {notaMe}")
        print(f"La nota mas alta es {notaAL}")
        print(f"La nota mas baja es {notaBa}")
