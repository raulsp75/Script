function ad {
@"

MENU PARA USUARIOS Y GRUPOS DE AD
----------------------------------

1. Listar UO
2. Crear UO
3. Listar usuario de AD
4. Crear usuario de AD
5. Listar grupos
6. Crear grupo
7. Agregar miembro al grupo
8. Eliminar miembro del grupo
9. Ver graficamente
0. SALIR
"@
}

do {
    ad
    $opcion = Read-Host "Escoga una opcion"
    switch($opcion){
    1{
        $dom = Read-Host "Ingrese el primer nombre de dominio"
        $dom2 = Read-Host "Ingrese el segundo nombre de dominio"
        $dominio = "DC=$dom,DC=$dom2"
        Get-ADOrganizationalUnit -Filter * -SearchBase $dominio | Select-Object name | out-host
    }
    2{
        $dom = Read-Host "Ingrese el primer nombre de dominio"
        $dom2 = Read-Host "Ingrese el segundo nombre de dominio"
        $ou = Read-Host "Ingrse el nombre de la UO"
        $dominio = "DC=$dom,DC=$dom2"
        New-ADOrganizationalUnit -Name $ou -Path $dominio
    }
    3{
        $dom = Read-Host "Ingrese el primer nombre de dominio"
        $dom2 = Read-Host "Ingrese el segundo nombre de dominio"
        $dominio = "DC=$dom,DC=$dom2"  
        Get-ADUser -Filter * -SearchBase $dominio | Select-Object name | Out-Host
    }
    4{
        $dom = Read-Host "Ingrese el primer nombre de dominio"
        $dom2 = Read-Host "Ingrese el segundo nombre de dominio"
        $dominio = "DC=$dom,DC=$dom2"  
        $user = Read-Host "Introduzca el nombre del usuario"
        $contra = Read-Host "Introduzca la contraseña"
        New-ADUser -Name $user -SamAccountName $user -Enabled $true -AccountPassword (ConvertTo-SecureString $contra -AsPlainText -Force)
    }
    5{
        $dom = Read-Host "Ingrese el primer nombre de dominio"
        $dom2 = Read-Host "Ingrese el segundo nombre de dominio"
        $dominio = "DC=$dom,DC=$dom2"  
        Get-ADGroup -Filter * -SearchBase $dominio | Select-Object name | Out-Host
    }
    6{
        $ou = Read-Host "Introduzca el nombre de la ou para agregar el grupo"
        $dom = Read-Host "Ingrese el primer nombre de dominio"
        $dom2 = Read-Host "Ingrese el segundo nombre de dominio"
        $dominio = "OU=$ou,DC=$dom,DC=$dom2"
        $nombre = Read-Host "Introduzca el nombre del nuevo grupo"
        $groupscope = Read-Host "Introduzca el alcance del grupo (Global, DomainLocal, Universal)"
        $groupcategory = Read-Host "Ingresa la caategoria del ggrupo (Security, Distribution)"
        New-ADGroup -Name $nombre -SamAccountName $nombre -GroupScope $groupscope -GroupCategory $groupcategory -Path $dominio
    }
    7{
        $nombreGrupo = Read-Host "Nombre del grupo"
        $nombreUsuario = Read-Host "Introduzca nombre de usuario"
        Add-ADGroupMember -Identity $nombreGrupo -Members $nombreUsuario
    }
    8{
        $nombreGrupo = Read-Host "Nombre del grupo"
        $nombreUsuario = Read-Host "Introduzca nombre de usuario"
        Remove-ADGroupMember -Identity $nombreGrupo -Members $nombreUsuario
    }
    0{
        Write-Host "SALIENDO DEL MENU"
    }
    default{
        Write-Host "OPCION NO VALIDA"
    }
    }


} while ($opcion -ne 0)
