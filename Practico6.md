Práctico 6: 
find, grep, awk, rsync, y ssh
Son 12 ejercicios de bash para que  practiquen con los comandos find, grep, awk, rsync, y ssh en tareas de respaldos y revisión de logs. Cada ejercicio incluye una explicación clara de la tarea y está listo para subir a GitHub.

Ejercicio 1: Buscar archivos grandes con find
Descripción: Utiliza el comando find para buscar archivos que sean mayores a 100 MB en el directorio /var/log/ y guarda la salida en un archivo archivos_grandes.txt.
# Objetivo:
# Buscar archivos mayores a 100MB en /var/log y guardarlos en archivos_grandes.txt

find /var/log/ -type f -size +100M > archivos_grandes.txt

# Pregunta adicional para el alumno:
# ¿Cómo puedes cambiar el comando para buscar archivos que sean mayores a 500 MB?


Ejercicio 2: Buscar archivos modificados recientemente con find
Descripción: Usa el comando find para buscar archivos que hayan sido modificados en los últimos 7 días en el directorio /home/usuario/Documentos.
# Objetivo:
# Buscar archivos modificados en los últimos 7 días en /home/usuario/Documentos

find /home/usuario/Documentos -type f -mtime -7

# Pregunta adicional para el alumno:
# ¿Cómo puedes modificar el comando para buscar archivos que fueron modificados hace exactamente 10 días?



Ejercicio 3: Buscar texto en logs con grep
Descripción: Usa grep para buscar la palabra "ERROR" dentro de los archivos de log en /var/log/ y guarda los resultados en un archivo errores.log.
# Objetivo:
# Buscar la palabra "ERROR" en los archivos de log en /var/log y guardar el resultado en errores.log

grep -r "ERROR" /var/log/ > errores.log

# Pregunta adicional para el alumno:
# ¿Cómo puedes modificar el comando para buscar tanto "ERROR" como "error" en los archivos de log?

Ejercicio 4: Buscar líneas con un patrón usando grep
Descripción: Utilizar grep para buscar las líneas que contengan direcciones IP en un archivo de log syslog.
# Objetivo:
# Buscar líneas que contengan direcciones IP en el archivo syslog

grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' /var/log/syslog

# Pregunta adicional para el alumno:
# ¿Cómo puedes limitar el comando para buscar sólo las direcciones IP que comienzan con 192.168?

Ejercicio 5: Análisis de logs con awk
Descripción: Usa awk para extraer la quinta columna (usuario) del archivo /var/log/auth.log y contar cuántas veces aparece cada usuario.
# Objetivo:
# Extraer el usuario (quinta columna) de /var/log/auth.log y contar cuántas veces aparece cada usuario
awk '{print $5}' /var/log/auth.log | sort | uniq -c

# Pregunta adicional para el alumno:
# ¿Cómo puedes modificar el comando para mostrar los usuarios ordenados por cantidad de apariciones?


Ejercicio 6: Filtrar datos con awk
Descripción: Filtra las líneas del archivo log.txt que tengan un número mayor a 1000 en la tercera columna.
# Objetivo:
# Filtrar las líneas que tengan un número mayor a 1000 en la tercera columna del archivo log.txt

awk '$3 > 1000' log.txt

# Pregunta adicional para el alumno:
# ¿Cómo puedes modificar el comando para filtrar las líneas donde el número en la tercera columna sea menor a 500?


Ejercicio 7: Sincronización de directorios con rsync
Descripción: Sincroniza el contenido del directorio /home/usuario/proyecto/ al servidor remoto backup_servidor usando rsync.
# Objetivo:
# Sincronizar el directorio /home/usuario/proyecto/ al servidor remoto backup_servidor usando rsync

rsync -avz /home/usuario/proyecto/ usuario@backup_servidor:/backups/proyecto

# Pregunta adicional para el alumno:
# ¿Cómo puedes modificar el comando para que elimine archivos en el destino que ya no existen en el origen?






Ejercicio 8: Respaldo incremental con rsync
Descripción: Realiza un respaldo incremental del directorio /var/www/ al servidor backup_servidor, excluyendo los archivos .tmp.
# Objetivo:
# Realizar un respaldo incremental de /var/www/ al servidor remoto, excluyendo archivos .tmp

rsync -avz --exclude='*.tmp' /var/www/ usuario@backup_servidor:/backups/www

# Pregunta adicional para el alumno:
# ¿Cómo puedes agregar una opción para comprimir los archivos durante la transferencia?

Ejercicio 9: Uso básico de ssh para conexión remota
Descripción: Conéctate a un servidor remoto utilizando ssh y ejecuta el comando df -h para ver el espacio en disco.
# Objetivo:
# Conectarse a un servidor remoto y ejecutar el comando df -h para ver el uso de disco

ssh usuario@servidor_remoto "df -h"

# Pregunta adicional para el alumno:
# ¿Cómo puedes copiar un archivo local al servidor remoto usando `scp`?

Ejercicio 10: Ejecutar comandos remotos con ssh
Descripción: Usa ssh para conectarse a un servidor y reiniciar el servicio Apache.
# Objetivo:
# Conectarse a un servidor remoto y reiniciar el servicio Apache

ssh usuario@servidor_remoto "sudo systemctl restart apache2"

# Pregunta adicional para el alumno:
# ¿Cómo puedes verificar el estado del servicio Apache después de reiniciarlo?

Ejercicio 11: Automatización de respaldo con ssh y rsync
Descripción: Crea un script para automatizar el respaldo diario del directorio /home/usuario/Documentos a un servidor remoto mediante ssh y rsync.

# Objetivo:
# Automatizar el respaldo diario de /home/usuario/Documentos a un servidor remoto

#!/bin/bash
rsync -avz /home/usuario/Documentos/ usuario@servidor_remoto:/backups/documentos

# Pregunta adicional para el alumno:
# ¿Cómo puedes configurar este script para que se ejecute automáticamente todos los días a las 2 AM usando cron?


Ejercicio 12: Revisión de logs con grep y awk
Descripción: Revisa el archivo de logs /var/log/syslog para encontrar todas las entradas relacionadas con "sshd" y contar cuántas veces aparece cada IP.
# Objetivo:
# Buscar entradas relacionadas con sshd en /var/log/syslog y contar las IPs que aparecen

grep "sshd" /var/log/syslog | awk '{print $1}' | sort | uniq -c

# Pregunta adicional para el alumno:
# ¿Cómo puedes modificar el comando para mostrar solo las IPs que aparezcan más de 5 veces
