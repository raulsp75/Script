#Script que me muestre un listado de todos los inicios de sesión que se han realizado entre esas dos fechas

#Pide la fecha de inicio y fin
$fechaInicio = Read-Host "Ingrese la fecha de inicio. (Ej: 2023-07-28) "
$fechaFin = Read-Host "Ingrese la fecha de fin. (Ej: 2023-12-01) "


#Filtra los registros de inicio de sesion por fecha de inicio y de fin. Y que no sean del system
Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    ID = 4624
    StartTime = [datetime]$fechaInicio
    EndTime = [datetime]$fechaFin
} | Where-Object { $_.Properties[5].Value -ne "SYSTEM" } | Select-Object TimeCreated, @{Name="Usuario";Expression={$_.Properties[5].Value}}
