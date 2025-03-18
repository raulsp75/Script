#Pedimos los datos
vel1 = float(input("¿Qué velocidad tiene la primera moto? (km/h)"))
vel2 = float(input("¿Qué velocidad tiene la segunda moto? (km/h)"))
dis = float(input("¿A qué distancia se encuentra una de la otra? (km)"))
#Definimos la función
def calculo(vel1,vel2,dis):
 if vel1 >= vel2: #En caso de que la moto 1 vaya más rápido que la moto 2
  print("Las motos no se llegarán a alcanzar")
 else: #De no ser así
  t = dis/(vel2-vel1)
  return (f"La segunda moto alcanzará a la primera en {t} horas")
#Llamamos a la función
calculo(vel1,vel2,dis)
