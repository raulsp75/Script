clear-host
#Aquí disponemos de unas funciones que harán de menú para las distintas secciones del script. 

#Menú principal
function menu{
@"

    ---- MENÚ DISCOS ----

        1) Listar Discos
        2) Listar Volumenes
        3) Crear RAID-0
        4) Crear RAID-1
        5) Crear RAID-5
        0) Salir del menu



"@
}
#Menú Raid0
function rds {
@"
        ------ MENÚ RAID-0 ------

        0) Salir del menú de RAID-0

        1) Seleccionar discos y darles formato

        2) Selecionar volumen y solicitar sistema de archivos

"@
}
#Menú Raid1
function rds1 {
@"

         ------ MENÚ RAID-1 ------

        0) Salir del menú de RAID-1

        1) Seleccionar discos y darles formato

        2) Selecionar volumen y solicitar sistema de archivos

"@
}
#Menú Raid5
function rds5 {
@"
         ------ MENÚ RAID-5 ------

        0) Salir del menú de RAID-5

        1) Seleccionar discos y darles formato

        2) Selecionar volumen y solicitar sistema de archivos

"@
}

#Declaramos un bucle principal que recoja la opción $i en un switch que llame a las funciones del menú, según lo escogido. Se cerrará con la opción 0
do{
menu
$i = Read-Host "Seleccione una opcion"
switch($i){

        1{
@"
         list disk
"@ | diskpart
       
        }
        2{
          get-volume | out-host
        }
        3{
         #Esta opción englobará las opciones del RAID-0 y se realizará con un switch dentro de un bucle do while que se cerrará con la opción 0
           do{
           rds
           $rr=read-host "Seleccione una opcion"
           switch($rr){
           1{
           #Instrucciones de conversión de discos para la función de diskpart en modo RAID-0
@"
        list disk
"@ | diskpart
           $disk = Read-Host "Selecciona el disco 1 con el que quieres trabajar"
           $disk1 = Read-Host "Selecciona el disco 2 con el que quieres trabajar"

@"
       
        select disk $disk
        clean
        conv gpt
        convert dynamic


        select disk $disk1
        clean
        conv gpt
        convert dynamic


        create volume stripe disk=$disk,$disk1
        list volume
"@ | diskpart
            }
            2{
            #Instrucciones de conversión de volumenes de diskpart
@"
        list volume      
"@ | diskpart 
          $vol = Read-Host "Selecciona el volumen"
          $let = Read-Host "Elija una letra para el volumen"
@"
        list volume
        select volume $vol 
        format fs=NTFS 
        assign letter=$let
       
       
"@ | diskpart

            }

            0{
                Write-host "Saliendo del menú de Raid 0"
            }
            }
         }while($rr -ne 0)

         }
         #Esta opción englobará las opciones del RAID-1
        4{
            do{
            rds1
            $rr1=read-host "Seleccione una opción"
            switch($rr1){

            1{
            #Instrucciones de conversión de discos para la función de diskpart en modo RAID-1
@"
        list disk
"@ | diskpart
            $disk = Read-Host "Selecciona el disco 1 con el que quieres trabajar"
            $disk1 = Read-Host "Selecciona el disco 2 con el que quieres trabajar"
       

@"
       
        select disk $disk
        clean
        conv gpt
        convert dynamic


        select disk $disk1
        clean
        conv gpt
        convert dynamic


        create volume mirror disk=$disk,$disk1 
        list volume
"@ | diskpart

            }
            2{
            #Instrucciones de conversión de volumenes de diskpart
@"
        list volume      
"@ | diskpart 
          $vol = Read-Host "Selecciona el volumen"
          $let = Read-Host "Elija una letra para el volumen"
@"
        list volume
        select volume $vol 
        format fs=NTFS 
        assign letter=$let
       
       
"@ | diskpart

            }
            0{
              Write-host "Saliendo del menú RAID-1" 
            }

            }          
            }while($rr1 -ne 0)
           } 
           #Esta opción englobará las opciones del RAID-5
        5{
            do{
            rds5
            $rr5=read-host "Seleccione una opción"
            switch($rr5){
            
            1{
            #Instrucciones de conversión de discos para la función de diskpart en modo RAID-5
@"
        list disk
"@ | diskpart
           $disk = Read-Host "Selecciona el disco 1 con el que quieres trabajar"
           $disk1 = Read-Host "Selecciona el disco 2 con el que quieres trabajar"
           $disk2 = Read-Host "Selecciona el disco 3 con el que quieres trabajar"

@"
       
        select disk $disk
        clean
        conv gpt
        convert dynamic


        select disk $disk1
        clean
        conv gpt
        convert dynamic

        select disk $disk2
        clean
        conv gpt
        convert dynamic

        create volume raid disk=$disk,$disk1,$disk2
        list volume
"@ | diskpart
            }
            2{

@"
        list volume      
"@ | diskpart 
          $vol = Read-Host "Selecciona el volumen"
          $let = Read-Host "Elija una letra para el volumen"
@"
        list volume
        select volume $vol 
        format fs=NTFS 
        assign letter=$let
       
       
"@ | diskpart

            }
            0{
                Write-host "Saliendo del menú de Raid 0"
            }
            }

            }while($rr5 -ne 0)

    
        
        }
        0{
            Write-host "Saliendo del menú de discos"
        }
        default{
            write-host "Opción no válida, introduzca una opción de la lista"
        } 
        }
} while ( $i -ne 0)
