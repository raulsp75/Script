# Listas de ingredientes
$vege = @("Pimiento", "Tofu")
$novege = @("Peperoni", "Jamon", "Salmon")

# Mensaje de bienvenida
Write-Host "Bienvenido a Pizzería Bella Napoli!"
$pizza = Read-Host "¿Quieres una pizza vegetariana o no vegetariana?"

if ($pizza -eq "vegetariana") {
    Write-Host "Todas nuestras pizzas llevan mozzarella y tomate."
    Write-Host "Solo puedes elegir un ingrediente adicional. Ingredientes disponibles: $($vege -join ', ')"
    
    $ingrediente = Read-Host "Dime qué ingrediente quieres añadir"

    # Validar que el ingrediente esté en la lista de vegetarianos
    if ($vege -contains $ingrediente) {
        Write-Host "Has elegido una **pizza vegetariana** con los siguientes ingredientes: Mozzarella, Tomate y $ingrediente."
    } else {
        Write-Host "Error: Debes elegir solo un ingrediente válido de la lista. *Pedido cancelado*."
    }

} elseif ($pizza -eq "no vegetariana") {
    Write-Host "Todas nuestras pizzas llevan mozzarella y tomate."
    Write-Host "Solo puedes elegir un ingrediente adicional. Ingredientes disponibles: $($novege -join ', ')"
    
    $ingrediente = Read-Host "Dime qué ingrediente quieres añadir"

    # Validar que el ingrediente esté en la lista de no vegetarianos
    if ($novege -contains $ingrediente) {
        Write-Host "Has elegido una **pizza no vegetariana** con los siguientes ingredientes: Mozzarella, Tomate y $ingrediente."
    } else {
        Write-Host "Error: Debes elegir solo un ingrediente válido de la lista. *Pedido cancelado*."
    }

} else {
    Write-Host "Error: Solo puedes elegir 'vegetariana' o 'no vegetariana'. *Pedido cancelado*."
}

