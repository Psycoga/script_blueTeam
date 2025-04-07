### Instalación y configuración segura de ufw

UFW es una herramienta de configuración de cortafuegos que facilita la gestión de las reglas de iptables. A continuación, se describen los pasos para instalar y configurar UFW en Kali Linux.
### Paso 1: Actualizar el sistema
Antes de instalar cualquier paquete, es recomendable actualizar el sistema. Abre una terminal y ejecuta los siguientes comandos:
```bash
sudo apt update
sudo apt upgrade -y
```
### Paso 2: Instalar UFW
Para instalar UFW, ejecuta el siguiente comando en la terminal:
```bash
sudo apt install ufw -y
```
** Normalmente, UFW ya está instalado en Kali Linux, pero si no lo está, puedes instalarlo con el comando anterior.**
### Paso 3: Habilitar UFW
Para habilitar UFW, ejecuta el siguiente comando:
```bash
sudo ufw enable
```
Esto activará el cortafuegos y comenzará a aplicar las reglas predeterminadas.
### Paso 4: Configurar reglas de UFW
Puedes agregar reglas para permitir o denegar el tráfico en función de tus necesidades. Aquí hay algunos ejemplos de comandos para configurar reglas comunes:
```bash
# Permitir tráfico SSH (puerto 22)
sudo ufw allow ssh
# Normalente el puerto SSH es el 22, pero si lo cambiaste, esta es la mejor opción, ya que el predefinido siempre es más vulnerable. En este caso vamos a poner uno poco común.
```
### Paso 5: Cambiar configuración ssh para el puerto nuevo
```bash
sudo nano /etc/ssh/sshd_config
```
Busca la línea que dice `#Port 22` y cámbiala por el puerto que hayas elegido. Por ejemplo, si elegiste el puerto 2222, la línea debería verse así:
```bash
Port 2222
```
![alt text](/ANEXOS/image_ssh.png)

Guarda el archivo y cierra el editor.
### Paso 6: Reiniciar el servicio SSH
```bash
sudo systemctl restart ssh
```
### Paso 7: Permitir el nuevo puerto SSH
```bash
sudo ufw allow 2222/tcp
```

