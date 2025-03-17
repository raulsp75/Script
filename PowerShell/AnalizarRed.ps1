<#
    Comprobar a partir de una IP de red, que PC's están encendidos.
    Entrada: "192.168.1." (parámetro [string] obligatorio)
    Salida:
        192.168.1.1 ... [ENCENDIDO]
        192.168.1.5 ... [ENCENDIDO]
        192.168.1.254 ... [ENCENDIDO]

    Comando: Tets-Connection
#>
Param(
    [Parameter(Mandatory=$true)][string]$networkIp
)

if ($networkIp -notmatch "^([0-9]{1,3}\.){3}[0-9]{1,3}$") {
    Write-Error "La dirección IP $networkIp no es correcta"
    Exit 1
}

$index = $networkIp.LastIndexOf(".")
$first = $networkIp.Substring(0, $index)

for ($n = 1; $n -le 254; $n++) {
    $ip = $first + "." + $n
    if (Test-Connection $ip -Count 1 -ErrorAction SilentlyContinue) {
        Write-Host -ForegroundColor Yellow "$ip ... [ENCENDIDO]"
    } else {
        Write-Host -ForegroundColor Red "$ip ... [APAGADO]"
    }
}
