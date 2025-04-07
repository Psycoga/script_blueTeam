### Instalación y configuración knockd
Knockd es una herramienta de seguridad que permite proteger los servicios de red mediante el uso de "knock" (golpes) en puertos específicos. A continuación, se describen los pasos para instalar y configurar knockd en Kali Linux.
### Paso 1: Actualizar el sistema
Antes de instalar cualquier paquete, es recomendable actualizar el sistema. Abre una terminal y ejecuta los siguientes comandos:
```bash
sudo apt update
sudo apt upgrade -y
```
### Paso 2: Instalar knockd
Para instalar knockd, ejecuta el siguiente comando en la terminal:
```bash
sudo apt install knockd -y
```
### Paso 3: Configurar knockd
El archivo de configuración principal de knockd se encuentra en `/etc/knockd.conf`. Abre este archivo con un editor de texto, por ejemplo, `nano`:
```bash
sudo nano /etc/knockd.conf
```
Dentro de este archivo, puedes definir los "knocks" y las acciones a realizar. Aquí tienes un ejemplo de configuración:
```ini
[openSSH]
    sequence    = 7000,8000,9000
    seq_timeout = 5
    command     = /usr/bin/ufw allow 22/tcp
    tcpflags    = syn
[closeSSH]
    sequence    = 9000,8000,7000
    seq_timeout = 5
    command     = /usr/bin/ufw deny 22/tcp
    tcpflags    = syn
```
![alt text](/ANEXOS/image_knockd.png)
En este ejemplo, cuando se envían "knocks" a los puertos 7000, 8000 y 9000 en secuencia, se ejecuta el comando para permitir el acceso SSH (puerto 22). La secuencia inversa (9000, 8000, 7000) cierra el acceso SSH.
### Paso 4: Habilitar y reiniciar knockd
Después de realizar los cambios en la configuración, guarda el archivo y cierra el editor. Luego, habilita y reinicia el servicio knockd para aplicar los cambios:
```bash
sudo systemctl enable knockd
sudo systemctl start knockd
```
![alt text](/ANEXOS/image_knockd2.png)

### Paso 5: Probar knockd
Para probar knockd, puedes usar el comando `knock` desde otra máquina. Asegúrate de que el puerto 22 esté cerrado antes de ejecutar el siguiente comando:
```bash
knock <IP_DEL_SERVIDOR> 7000 8000 9000
```
Esto enviará los "knocks" a los puertos 7000, 8000 y 9000. Si la configuración es correcta, el puerto 22 debería abrirse y podrás acceder al servidor mediante SSH.