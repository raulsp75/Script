def EsMultiplo(x,y):
    if x%y==0:
        return(f"El número {y} es múltiplo de {x}")
    else:
        return(f"El número {y} no es múltiplo de {x}")

num1= int(input("Selecciona numero 1: "))
num2= int(input("Selecciona numero 2: "))

print(EsMultiplo(num1,num2))
