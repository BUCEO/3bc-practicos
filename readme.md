#Sistema de Respaldo Automatizado con Menú Interactivo

Este proyecto es un script de respaldo automatizado para sistemas Linux que se ejecuta al inicio de la sesión del terminal. Proporciona un menú interactivo similar al de pfSense para seleccionar diferentes tipos de respaldos, incluyendo respaldos locales, a USB, y a una unidad de red usando scp. Los parámetros de configuración se almacenan en un archivo separado para facilitar la personalización.

Archivo de Configuración (backup_config.cfg)
Este archivo contiene las configuraciones necesarias para el script, como las rutas de los directorios de origen y destino, así como la configuración para respaldos en red y la clave SSH.

ini
Copy code
# backup_config.cfg

# Directorio de origen
SOURCE_DIR=/ruta/al/directorio/a/respaldar

# Directorio de destino local
LOCAL_DEST_DIR=/ruta/al/directorio/de/respaldo

# Punto de montaje del USB
USB_MOUNT=/ruta/al/montaje/usb

# Configuración de respaldo en red
REMOTE_USER=usuario
REMOTE_HOST=hostname.o.ip
REMOTE_DIR=/ruta/en/el/servidor/remoto

# Clave privada para la conexión SSH
SSH_KEY=/ruta/a/tu/clave_privada

# Archivo de logs
LOG_FILE=/ruta/al/directorio/de/logs/respaldo.log
Detalles de Configuración
SOURCE_DIR: El directorio que se desea respaldar.
LOCAL_DEST_DIR: La ubicación donde se almacenarán los respaldos en el disco local.
USB_MOUNT: El punto de montaje del dispositivo USB donde se almacenarán los respaldos.
REMOTE_USER, REMOTE_HOST, REMOTE_DIR: Configuraciones necesarias para realizar respaldos en una unidad de red utilizando scp.
SSH_KEY: La ruta a la clave privada utilizada para la autenticación SSH al realizar respaldos en red.
LOG_FILE: El archivo de log donde se registrarán todas las operaciones de respaldo.
Script de Respaldo (backup_menu.sh)
Este script muestra un menú interactivo al iniciar el sistema, permitiendo al usuario seleccionar el tipo de respaldo que desea realizar.

bash
Copy code
#!/bin/bash

# Cargar configuración desde el archivo
source /ruta/a/backup_config.cfg

# Función para respaldo completo
full_backup() {
    echo "Realizando respaldo completo en $DEST_DIR..."
    tar -czf "$DEST_DIR/full_backup_$(date +%Y%m%d_%H%M%S).tar.gz" -C "$SOURCE_DIR" .
    echo "Respaldo completo realizado en $(date)" >> "$LOG_FILE"
    echo "Respaldo completo realizado con éxito."
}

# Función para respaldo incremental usando rsync
incremental_backup() {
    echo "Realizando respaldo incremental en $DEST_DIR..."
    rsync -av --link-dest="$DEST_DIR/last_backup" "$SOURCE_DIR" "$DEST_DIR/incremental_backup_$(date +%Y%m%d_%H%M%S)"
    echo "Respaldo incremental realizado en $(date)" >> "$LOG_FILE"
    echo "Respaldo incremental realizado con éxito."
}

# Función para respaldo en red usando scp con clave privada especificada
network_backup() {
    echo "Realizando respaldo completo en la unidad de red $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR..."
    tar -czf - -C "$SOURCE_DIR" . | ssh -i "$SSH_KEY" "$REMOTE_USER@$REMOTE_HOST" "cat > $REMOTE_DIR/backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    echo "Respaldo en red realizado en $(date)" >> "$LOG_FILE"
    echo "Respaldo en red realizado con éxito."
}

# Función para mostrar el log de respaldos
view_log() {
    echo "Mostrando log de respaldos:"
    cat "$LOG_FILE"
}

# Función para mostrar el menú
show_menu() {
    echo "-----------------------------------"
    echo " SISTEMA DE RESPALDOS"
    echo "-----------------------------------"
    echo "1) Respaldo completo en disco local"
    echo "2) Respaldo incremental en disco local"
    echo "3) Respaldo completo en USB"
    echo "4) Respaldo completo en unidad de red"
    echo "5) Ver log de respaldos"
    echo "6) Salir"
    echo "-----------------------------------"
    echo -n "Seleccione una opción: "
    read opt
    case $opt in
        1) DEST_DIR="$LOCAL_DEST_DIR"; full_backup ;;
        2) DEST_DIR="$LOCAL_DEST_DIR"; incremental_backup ;;
        3) DEST_DIR="$USB_MOUNT"; full_backup ;;
        4) network_backup ;;
        5) view_log ;;
        6) exit 0 ;;
        *) echo "Opción inválida!"; sleep 1; show_menu ;;
    esac
}

# Mostrar el menú al inicio
show_menu
Detalles del Script
Carga de Configuración: El script carga las configuraciones desde backup_config.cfg al inicio, permitiendo la fácil modificación de los parámetros sin tener que editar el código.

Funciones de Respaldo:

full_backup: Realiza un respaldo completo comprimiendo todo el directorio de origen.
incremental_backup: Realiza un respaldo incremental usando rsync, copiando solo los archivos que han cambiado.
network_backup: Realiza un respaldo completo en una unidad de red utilizando scp y una clave privada específica.
Menú Interactivo: El menú permite al usuario seleccionar entre diferentes tipos de respaldos o ver el log de operaciones.

Configuración de Claves SSH para Respaldos
Para realizar respaldos a través de scp de manera segura y sin necesidad de ingresar una contraseña cada vez, puedes usar un par de claves SSH (clave pública y privada). A continuación, se detallan los pasos para configurar y utilizar estas claves.

Generar Claves SSH
Si aún no tienes un par de claves SSH, puedes generarlas utilizando el comando ssh-keygen.

bash
Copy code
ssh-keygen -t rsa -b 4096 -C "tu_correo@ejemplo.com"
Este comando generará un par de claves (una pública y una privada) en tu directorio ~/.ssh/. Por defecto, los archivos se llamarán id_rsa (clave privada) e id_rsa.pub (clave pública).

Copiar la Clave Pública al Servidor Remoto
Para permitir el acceso sin contraseña al servidor remoto, debes copiar tu clave pública al archivo ~/.ssh/authorized_keys del servidor remoto.

Utiliza el siguiente comando para copiar automáticamente tu clave pública al servidor remoto:

bash
Copy code
ssh-copy-id usuario@hostname.o.ip

Este comando añadirá tu clave pública al archivo ~/.ssh/authorized_keys del usuario remoto, permitiéndote conectarte sin ingresar una contraseña.

Especificar la Clave Privada al Usar scp
Cuando uses scp en tu script, puedes especificar la clave privada que deseas usar con la opción -i. Esto es útil si tienes múltiples claves privadas o si la clave no se encuentra en la ubicación predeterminada (~/.ssh/id_rsa).

bash
Copy code
scp -i /ruta/a/tu/clave_privada archivo_a_transferir usuario@hostname.o.ip:/ruta/de/destino

Modificación de .bashrc
Para que el menú se despliegue automáticamente al iniciar el sistema, debes agregar la siguiente línea al final de tu archivo .bashrc:

bash
Copy code
# Ejecutar el script de respaldos al inicio
/ruta/a/backup_menu.sh

Flujo de Ejecución
Inicio del Sistema: Al iniciar sesión en el terminal, el menú de respaldo se muestra automáticamente.
Selección de Opción: El usuario selecciona una opción del menú ingresando el número correspondiente.
Ejecución del Respaldo: Dependiendo de la opción seleccionada, se ejecuta el respaldo deseado.
Este proyecto está diseñado para facilitar la automatización de respaldos en sistemas Linux, proporcionando una interfaz simple y accesible para usuarios de cualquier nivel.
