cad=input("Introduce una cadena: ")
sub=input("Introduce una subcadena: ")

if sub in cad:
    print(f"La subcadena: {sub} está en la cadena: {cad}")
else:
    print(f"La subcadena: {sub} NO está en la cadena: {cad}")
