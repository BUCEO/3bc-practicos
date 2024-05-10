# 3bc-practicos
1. Instalar Linux Servidor

   a) Instalar servidor SSH (`apt install open-sshserver`).

   b) Configurar accesos con clave pública/clave privada (`ssh-keygen`).

   c) copiar la clave en el servidor
     ssh-copy-id usuario@ip 
     o
     scp ruta-origen ruta-destino

   c) Instalar el paquete `net-tools`.

2. Acceder desde cliente Linux o Windows

   a) Ingresar al servidor SSH instalado en el práctico anterior.

   b) Ingresar por SSH utilizando la llave generada anteriormente.

