#La pizzería Bella Napoli ofrece pizzas vegetarianas y no vegetarianas a sus clientes. Los ingredientes para cada tipo de pizza aparecen a continuación.
#Ingredientes vegetarianos: Pimiento y tofu. Ingredientes no vegetarianos: Peperoni, Jamón y  Salmón. Escribir un programa que pregunte al usuario si quiere una pizza vegetariana o no, y en
#función de su respuesta le muestre un menú con los ingredientes disponibles para que elija. Solo se puede eligir un ingrediente además de la mozzarella y el tomate que están en todas las pizzas.
#Al final se debe mostrar por pantalla si la pizza elegida es vegetariana o no y todos los ingredientes que lleva.

function pizzeria{ 
@"
    1) Pizza_Vegetariana
    2) Pizza_Comun
    3) Salir

"@


}
do{
    pizzeria
    $pi = read-host "selecciona una opción entre 1-3"
    switch ($pi){
        1{
            write-host "Tiene que escoger entre estos 2 ingredientes"
            write-host "`t1- Tofu"
            Write-Host "`t2- Pimiento"
            $ingredientv = read-host "Escoja el ingrediente que desee: (Mozzarella y tomate ya incluidos)"
            if ($ingredientv -eq 1){
                write-host "Usted eligió la pizza vegetariana de: Mozzarella, tomate y Tofu"
            } else {
                write-host "Usted eligió la pizza vegetariana de: Mozzarella, tomate y Pimiento"  
            }
    
        }
        2{
            write-host "Tiene que escoger entre estos 3 ingredientes"
            write-host "`t1 - Peperoni"
            write-host "`t2 - Jamón"
            write-host "`t3 - Salmón"
            $ingredientv = read-host "Escoja el ingrediente que desee: (Mozzarella y tomate ya incluidos)"
            if ($ingredientv -eq 1){
                write-host "Usted eligió la pizza común de: Mozzarella, tomate y peperoni"
            } elseif ($ingredientv -eq 2) {
                write-host "Usted eligió la pizza común de: Mozzarella, tomate y jamón"  
            } else {
                write-host "Usted eligió la pizza común de: Mozzarella, tomate y salmón"
            }
        }
        3{
            write-host "Saliendo del menú..."
        }
        default{ write-host "Opción no válida!"
        }
    } 
} while ($pi -ne 3)
