#Imprimir la tabla de multiplicar de un número almacenado en una variable utilizando rangos. La
#salida para el número 5 sería:

numero = 5
resultado = 0


for i in range(1,11,1):
    resultado = numero * i
    print(numero,"*",i,"=",resultado)
