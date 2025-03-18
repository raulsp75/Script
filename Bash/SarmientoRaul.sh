crear(){
	#Declaramos variables
	fichero="fichero_vacio"
	tam=1024
	#Si existe el $1
	if [ ! -z $1 ]; then
	   fichero="$1";
	fi
	#Si existe el $2
	if [ ! -z $2 ]; then
	   tam=$2;
	fi
	#Despues de cambiar valores si existes creamos el fichero con truncate
	truncate -s $tam K $fichero
	echo "Se ha creado el fichero $fichero con $tam Kilobytes"
}

romano(){
	read -p "Selecciona un número entre 1-200: " num
	#Si el número no esta entre 1-200
	if [[ $num -lt 0 || $num -gt 200 ]]; then
	   echo "El número seleccionado no está entre 1-200."
	#Sino que busque el romano en el case
	else
	   echo "El romano de el número $num es: "
	   case $num in
		1)echo "I";;
		2)echo "II";;
		3)echo "III";;
		4)echo "IV";;
		5)echo "V";;
		6)echo  "VI";;
		7)echo  "VII";;
		8)echo  "VII";;
		9)echo  "IX";;
		10)echo  "X";;
		11)echo  "XI";;
		12)echo  "XII";;
		13)echo  "XIII";;
		14)echo  "XIV";;
		15)echo  "XV";;
		16)echo  "XVI";;
		17)echo "XVII";;
		18)echo XVII;;
		19)echo  XIX;;
		20)echo  XX;;
		21)echo  XXI;;
		22)echo  XXII;;
		23)echo  XXII;;
		24)echo  XXIV;;
		25)echo  XXV;;
		26)echo  XXVI;;
		27)echo  XXVII;;
		28)echo  XXVII;;
		29)echo  XIX;;
		30)echo  XXX;;
		31)echo  XXXI;;
		32)echo  XXXII;;
		33)echo  XXXIII;;
		34)echo  XXXIV;;
		35)echo  XXXV;;
		36)echo  XXXVI;;
		37)echo  XXXVII;;
		38)echo  XXXVIII;;
		39)echo  XXXIX;;
		40)echo  XL;;
		41)echo  XLI;;
		42)echo  XLII;;
		43)echo  XLIII;;
		44)echo  XLIV;;
		45)echo  XLV;;
		46)echo  XLVI;;
		47)echo  XLVII;;
		48)echo  XLVIII;;
		49)echo  XLIX;;
		50)echo  L;;
		51)echo  LI;;
		52)echo  LII;;
		53)echo  LIII;;
		54)echo  LIX;;
		55)echo  LX;;
		56)echo  LVI;;
		57)echo  LVII;;
		58)echo  LVIII;;
		59)echo  LIX;;
		60)echo  LX;;
		61)echo  LXI;;
		62)echo  LXII;;
		63)echo  LXII;;
		64)echo  LXIV;;
		65)echo  LXV;;
		66)echo  LXVI;;
		67)echo  LXVII;;
		68)echo  LXVIII;;
		69)echo  LXIX;;
		70)echo  LXX;;
		71)echo  LXXI;;
		72)echo  LXXII;;
		73)echo  LXXIII;;
		74)echo  LXXIV;;
		75)echo  LXXV;;
		76)echo  LXXVI;;
		77)echo  LXXVII;;
		78)echo  LXXVIII;;
		79)echo  LXXIX;;
		80)echo  LXXX;;
		81)echo  LXXXI;;
		82)echo  LXXXII;;
		83)echo  LXXXIII;;
		84)echo  LXXXIV;;
		85)echo  LXXXV;;
		86)echo  LXXXVI;;
		87)echo  LXXXVII;;
		88)echo  LXXXVIII;;
		89)echo  LXXXIX;;
		90)echo  XC;;
		91)echo  XCI;;
		92)echo  XCII;;
		93)echo  XCIII;;
		94)echo  XCIV;;
		95)echo  XCV;;
		96)echo  XCVI;;
		97)echo  XCVII;;
		98)echo  XCVIII;;
		99)echo  XCIV;;
		100)echo CC;;
		101)echo "CI";;
                102)echo "CII";;
                103)echo "CIII";;
                104)echo "CIV";;
                105)echo "CV";;
                106)echo  "CVI";;
                107)echo  "CVII";;
                108)echo  "CVII";;
                109)echo  "CIX";;
                110)echo  "CX";;
                111)echo  "CXI";;
                112)echo  "CXII";;
                113)echo  "CXIII";;
                114)echo  "CXIV";;
                115)echo  "CXV";;
                116)echo  "CXVI";;
                117)echo  "CXVII";;
                118)echo  CXVII;;
                119)echo  CXIX;;
                120)echo  CXX;;
                121)echo  CXXI;;
                122)echo  CXXII;;
                123)echo  CXXII;;
                124)echo  CXXIV;;
                125)echo  CXXV;;
                126)echo  CXXVI;;
                127)echo  CXXVII;;
                128)echo  CXXVII;;
                129)echo  CXIX;;
                130)echo  CXXX;;
                131)echo  CXXXI;;
                132)echo  CXXXII;;
                133)echo  CXXXIII;;
                134)echo  CXXXIV;;
                135)echo  CXXXV;;
                136)echo  CXXXVI;;
                137)echo  CXXXVII;;
                138)echo  CXXXVIII;;
                139)echo  CXXXIX;;
                140)echo  CXL;;
                141)echo  CXLI;;
                142)echo  CXLII;;
                143)echo  CXLIII;;
                144)echo  CXLIV;;
                145)echo  CXLV;;
                146)echo  CXLVI;;
                147)echo  CXLVII;;
                148)echo  CXLVIII;;
                149)echo  CXLIX;;
                150)echo  CL;;
                151)echo  CLI;;
                152)echo  CLII;;
                153)echo  CLIII;;
                154)echo  CLIX;;
                155)echo  CLX;;
                156)echo  CLVI;;
                157)echo  CLVII;;
                158)echo  CLVIII;;
                159)echo  CLIX;;
                160)echo  CLX;;
                161)echo  CLXI;;
                162)echo  CLXII;;
                163)echo  CLXII;;
                164)echo  CLXIV;;
                165)echo  CLXV;;
                166)echo  CLXVI;;
                167)echo  CLXVII;;
                168)echo  CLXVIII;;
                169)echo  CLXIX;;
                170)echo  CLXX;;
                171)echo  CLXXI;;
                172)echo  CLXXII;;
                173)echo  CLXXIII;;
                174)echo  CLXXIV;;
                175)echo  CLXXV;;
		176)echo  CLXXVI;;
                177)echo  CLXXVII;;
                178)echo  CLXXVIII;;
                179)echo  CLXXIX;;
                180)echo  CLXXX;;
                181)echo  CLXXXI;;
                182)echo  CLXXXII;;
                183)echo  CLXXXIII;;
                184)echo  CLXXXIV;;
                185)echo  CLXXXV;;
                186)echo  CLXXXVI;;
                187)echo  CLXXXVII;;
                188)echo  CLXXXVIII;;
                189)echo  CLXXXIX;;
                190)echo  CXC;;
                191)echo  CXCI;;
                192)echo  CXCII;;
                193)echo  CXCIII;;
                194)echo  CXCIV;;
                195)echo  CXCV;;
                196)echo  CXCVI;;
                197)echo  CXCVII;;
                198)echo  CXCVIII;;
                199)echo  CXCIV;;
                200)echo  CC;;
		esac
		fi
}

auto(){
	#Guardamos en un variable el contenido
	vacio=$(ls /mnt/usuarios)
	#Si esta vacio
	if [[ ! -n $vacio ]]; then
	   echo "El directorio está /mnt/usuarios vacio"
	#Si esta lleno
	else
	   #Si recorremos los variables de vacio y creamos los usuarios
	   for usu in $vacio; do
		useradd $usu
		echo "El usuario $usu ha sido creado"
		#Con el While leemos el contenido de los archivos y creamos esos directorios
		while IFS= read -r carpeta; do
		    if [ -n $carpeta ]; then
			mkdir -p /home/$usu/$carpeta
			echo "La carpeta /home/$usu/$carpeta"
		    fi
		done < /mnt/usuarios/$usu
		#Eliminamos la carpeta
		rm "/mnt/usuarios/$usu"
		echo "La carpeta /mnt/usuarios/$usu ha sido eliminada"
	    done
	fi
}

lista(){
	#Pedimos la lista
	read -p "Seleccione la lista: " lis
	lista=$(find / -type f -name "$lis" 2>/dev/null)
	#Comprobamos si existe, si no existe la creamos
	if [[ ! -n $lista ]]; then
	   echo "El elemento $lis no existe. Creando..."
	   touch $lis
	fi
	ruta=$(find / -type f -name "$lis" 2>/dev/null)
	read -p "Selecciona el elemento que quieres añadir a la lista: " ele
	#Comprobamos si el elemento existe en la lista
	if  cat "$ruta" | grep "$ele" ; then
	    echo "El elemento $ele ya está en $contenido"
	#Si no lo añadimos
	else
	    echo "$ele" >> "$ruta"
	    echo "El elemento $ele se ha añadido a la lista: $lis."
	fi
	#Contamos los elementos y lo mostramos
	num=$(cat "$ruta" | wc -l )
	echo "Hay un total de $num elementos en la lista $lis"
}

samba(){
	#Con este comando te instala samba
	apt install smbclient *>/dev/null
	echo "El samba ha sido instalado..."
}


op=1
while [ $op != 0 ]; do
	echo "Menú"
	echo "0. Salir"
	echo "1. Crear"
	echo "2. Romano ):"
	echo "3. Automatizar"
	echo "4. Lista"
	echo "5. Samba"
	read -p "Selecciona una opción: " op
	case $op in
	0) echo "Saliendo...";;
	1)read -p "Selecciona el nombre del fichero: " fic
	  read -p "Selecciona el tamaños del fichero: " tam
	  crear $fic $tam;;
	2)romano;;
	3)auto;;
	4)lista;;
	5)samba;;
	esac
	if [ $op != 0 ]; then
	    read -p "Presiona enter para continuar...."
	    echo "=================================="
	fi
done


