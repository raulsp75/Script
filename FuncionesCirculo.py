import math
def Perimetro(radio):
    peri= round(2*(radio * math.pi),2)
    area= round(math.pi*(radio*radio),2)
    return(f"El perimetro del circulo es: {peri} y el area del circulo es: {area}")

rad=int(input("Selecciona el radio de la circunferencia en ctm: "))
print(Perimetro(rad))