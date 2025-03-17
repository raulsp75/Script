# Limpia la pantalla de la consola
Clear  

# Instala Active Directory Domain Services con herramientas de administración
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools  

# Importa el módulo de despliegue de Active Directory
Import-Module ADDSDeployment  

# Solicita el nombre del dominio
$domainname = Read-Host "Introduce un dominio"  

# Solicita la contraseña del Administrador en Modo Seguro
$pass = Read-Host "Introduzca una contraseña"  

# Convierte la contraseña a un formato seguro
$domainAdminPassword = ConvertTo-SecureString $pass -AsPlainText -Force  

# Instala un nuevo bosque de Active Directory con el nombre de dominio proporcionado
Install-ADDSForest -DomainName $domainname -DomainMode WinThreshold -ForestMode WinThreshold -SafeModeAdministratorPassword $domainAdminPassword -Force:$true  

# Promueve el servidor a controlador de dominio dentro del bosque recién creado
Install-ADDSDomainController -DomainName $domainname -SafeModeAdministratorPassword $domainAdminPassword -Force:$true -ConfirmGc:$true  

# Muestra un mensaje confirmando que la promoción del dominio ha finalizado
Write-Host "El controlador de dominio ha sido promovido"  
