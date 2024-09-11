# Ejercicio 1: Buscar archivos grandes con find
# Descripción: Utiliza el comando find para buscar archivos que sean mayores a 100 MB en el directorio /var/log/ y guarda la salida en un archivo archivos_grandes.txt.
# Objetivo:
# Buscar archivos mayores a 100MB en /var/log y guardarlos en archivos_grandes.txt

find /var/log/ -type f -size +100M > archivos_grandes.txt

# Pregunta adicional para el alumno:
# ¿Cómo puedes cambiar el comando para buscar archivos que sean mayores a 500 MB?
