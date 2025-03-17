# Solicitar fechas de inicio y fin
$fechaInicio = Read-Host "Introduce la fecha de inicio (Formato: YYYY-MM-DD)"
$fechaFin = Read-Host "Introduce la fecha de fin (Formato: YYYY-MM-DD)"

# Convertir las fechas a objetos DateTime
$fechaInicio = [datetime]::ParseExact($fechaInicio, 'yyyy-MM-dd', $null)
$fechaFin = [datetime]::ParseExact($fechaFin, 'yyyy-MM-dd', $null)

# Obtener los eventos de inicio de sesión entre las fechas especificadas
$eventos = Get-WinEvent -LogName Security -FilterXPath "*[System[EventID=4624 and TimeCreated[@SystemTime>='$($fechaInicio.ToString("yyyy-MM-ddT00:00:00Z"))' and @SystemTime<='$($fechaFin.ToString("yyyy-MM-ddT23:59:59Z"))']]]"

# Mostrar los resultados
Write-Host "Inicios de sesión entre $fechaInicio y $fechaFin"
$eventos | ForEach-Object {
    $fechaHora = $_.TimeCreated
    $usuario = $_.Properties[5].Value
    Write-Host "Fecha y Hora: $fechaHora - Usuario: $usuario"
}
