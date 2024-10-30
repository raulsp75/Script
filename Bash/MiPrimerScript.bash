Menu
mostrar_menu() {
        echo "seleccione unas de las opciones:"
        echo "1.Loaded"
        echo "2.Not-Found"
        echo "3.Active"
        echo "4.Inactive"
        echo "5.Dead"
        echo "6.Running"
}
#Funciones
listar_servicios() {
case $1 in
      1) echo "Loaded:";     systemctl list-units --type=service --state=loaded ;;
      2) echo "Not-Found:";  systemctl list-units --type=service --state=not found ;;
      3) echo "Active:";     systemctl list-units --type=service --state=active ;;
      4) echo "Inactive:";   systemctl list-units --type=service --state=inactive ;;
      5) echo "Dead:";       systemctl list-units --type=service --state=dead ;;
      6) echo "Running:";    systemctl list-units --type=service --state=running ;;
      *) echo "Escoge un numero que aparezca en el menu"; exit 1 ;;
esac
}

#Mostrar Menu
mostrar_menu

#Leemos la opción
read -p "Ingrese un numero del menu:" opcion

#Llamamos a la funcion y la ejecutamos
listar_servicios $opcion

