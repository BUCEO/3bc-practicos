**Practico 6**


**ejercicio 1: Buscar archivo grandes con Find**

Se utiliza el comando find para buscar archivos mayores a 100mb en el directorio /var/log/ guardandolo en un archivo llamado archivos\_grandes.txt.

Comando:

find /var/log -type f -size +100M > archivos\_grandes.txt

para la pregunta de como cambiar el comando para que los archivos sean mayores a 50mb es practicamente igual.

find /var/log -type f -size +500M > archivos\_grandes.txt

**ejercicio 2: Buscar archivos modificados recientemente con find**

Se utiliza el comando find para buscar archivos modificados en los ltimos 7 dias en /home7usuario/Documentos.

Comando:
find /home/usuario/Documentos -type f -mtime -7

para la pregunta de como se puede modificar para bucar los que fueron modificados hace exactamente 10 dias se hace lo siguiente.

Comando:

find /home/usuario/Documentos -type f -mtime 10

**ejercicio 3: Busca texto en logs con grep**

Se utiliza grep para buscar la palabra ERROR dentro de los archivos en 7var/log/ y guardarlos en errores.log

Comando:

grep -r “ERROR” /var/log/ > errores.log

para la prgunta de como comidifar para bscar tanto ERROR como error se usa la opcion -i.

Comando:

grep -ri “error” /var/log/ > errores.log


**ejercicio 4: Buscar lineas con un patron sacando grep**

Se utiliza grep para buscar las lineas que contengan direcciones ip en un archivo log.

Comando:

grep -Eo “([0-9]{1,3}\.){3}[0-9]{1,3}” /var/log/syslog

para la pregunta de como limitar el comando para solo las direcciones ip que comienzan con 192.168 se modifica el patron de busqueda.

Comando:

grep -Eo “192\.168\.([0.9]{1,3}\.){1}[0-9]{1,3}” /var/log/syslog

**ejercicio 5: Analisis de lohs con awk**

se utiliza awk para extraer la quinta columna del archivo /var/log/auth.log.

Comando:

awk “{print $5}” /var/log/auth.log | sort | uniq -c

para la pregunta de como modificar el comando para mostrar los usuarios ordenados por cantidad se agrega el comando sot -nr

Comando:

awk “{print $5}” /var/log/auth.log | sort | uniq -c | sor -nr

**ejercicio 6: Filtrar datos con awk**

Se filtra las lineas del archivo log.txt que tengan un numero mor a 1000 en la tercer columna.

Comando:

awk “$3 > 1000” log.txt

Para la pregunta de como modificar el comando para que busque los datos en la tercer linea y que sea menor a 500.

Comando:

awk “$3 < 500” log.txt

**ejercicio 7: Sincronizacion de directorios con rsync**

Sincronizar el contenido del directorio /home/usuario/proyecto al servidor remoto backup\_servidor con rsync

Comando:

rsync -avz /home/usuario/proyecto <ususario@backup_servidor>:/backups/proyecto

para la pregunta de como modificar el comando para que eliminen archivos en el destino que ya no existen en el origen se usa –delete.

Comando:
rsync -avz --delete /home/usuario/proyecto <ususario@backup_servidor>:/backups/proyecto

**ejercicio 8: Respaldo incremental con rsync**

Se realiza un respaldo del directorio /var/www/ al servidor backup\_servidor excluyendo archivos .tmp

Comando:

rsync -avz --exclude=”\*.tmp” /var/www/ <ususario@backup_servidor>:/backups/www

para la pregunta de como agregar una opcion para que los archivos se compriman durante la transferencia se usa la opcion -z, la cual ya esta incluida en el codigo asi que sera igual.

Comando:

rsync -avz --exclude=”\*.tmp” /var/www/ <ususario@backup_servidor>:/backups/www

**ejercicio 9: Uso basico de ssh para conexión remota**

Se conecta a un servidor remoto usando ssh y se ejecuta el comano df -h para ver el espacio del disco.

Comando:

ssh <usuario@servidor_remoto> “df -h”

para la pregunta de como copiar un archivo local al servidor remoto se usa el comando scp de la siguiente manera.

Comando:

scp /usuario/Documento <usuario@servidor_remoto>:/backups/Archivos

**ejercicio 10: Ejecutar comandos remotos con ssh**

Se usa ssh para conectarse a un servidor y reiniciar el servicio Apache.

Comando:
ssh <usuario@servidor_remoto> “sudo systemctl restart apache2”

para la pregunta de como verificar el estado del servidor Apache despues de reiniciarlo se usa el siguiente comando.

Comando:
ssh <usuario@sevidor_remoto> “sudo systemctl status apache2”


**ejercicio 11: Automatizacion de respaldo con ssh y rsync**

Se usa un script para auomatizar el respaldo dario del directorio /home7ususario/Documentos a un servidor con ssh y rsync.

Comando:

rsync -avz /home/usuario/Doumentos/ <usuario@servidor_remoto>:/backups/documentos

para la pregunta de como configurar el script para que ejecute automaticamente todos los dias a las 2 AM usando cron se usa crontab -e.

Comando:


**ejercicio 12: Revision de logs con grep y awk**

Se revisa el archivo de los /var/log/syslog para encontrar todas la entradas relacinadas con sshd y cuantas veces aparece cada ip

Comando:

grep “sshd2 /var/log/syslog | awk “{print $1}” | sort | uniq -c

para la pregunta de como modificar el comando para mostrar solo las ip que aparecen mas de 5 veces se modifica el awk.

Comando:

grep “sshd2 7var/log/sylog | awk “{print $1}” | sort | uniq -c | awk “$1 > 5”

***Bryan Perez***
