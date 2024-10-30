#Cuenta Todos los servicios 
$Tot_ser=(Get-Service).Count

#Cuenta los servicios en ejecucion
$Ser_run=(Get-service | Where-Object {$_.Status -eq 'Running'}).count

#Cuenta los servicios que estan parados
$Ser_sto=(Get-service | Where-Object {$_.Status -eq 'Stopped'}).count

#Muestra por pantalla
Write-Host "Servicios totales: $Tot_ser, Servicios en Ejecución: $Ser_run, Servicios parados: $Ser_sto" -ForegroundColor green
