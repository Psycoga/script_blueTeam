## Instalación de Fail2Ban en Kali Linux
Fail2Ban es una herramienta de seguridad que ayuda a proteger los servidores contra ataques de fuerza bruta y otros tipos de intrusiones. A continuación, se describen los pasos para instalar y configurar Fail2Ban en Kali Linux.
### Paso 1: Actualizar el sistema
Antes de instalar cualquier paquete, es recomendable actualizar el sistema. Abre una terminal y ejecuta los siguientes comandos:
```bash
sudo apt update
sudo apt upgrade -y
```
### Paso 2: Instalar Fail2Ban
Para instalar Fail2Ban, ejecuta el siguiente comando en la terminal:
```bash
sudo apt install fail2ban -y
```
### Paso 3: Configurar Fail2Ban
Fail2Ban utiliza archivos de configuración para definir cómo debe comportarse. La configuración principal se encuentra en `/etc/fail2ban/jail.conf`, pero es recomendable no modificar este archivo directamente. En su lugar, crea un archivo de configuración local:
```bash
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```
Esto creará una copia del archivo de configuración principal que puedes editar sin perder los cambios en futuras actualizaciones.
### Paso 4: Editar la configuración
Abre el archivo `jail.local` con un editor de texto, por ejemplo, `nano`:
```bash
sudo nano /etc/fail2ban/jail.local
```
Dentro de este archivo, puedes configurar las siguientes opciones:
- **bantime**: Tiempo durante el cual la IP será bloqueada (en segundos).
- **findtime**: Tiempo durante el cual se cuentan los intentos de acceso fallidos (en segundos).
- **maxretry**: Número máximo de intentos fallidos antes de que se bloquee la IP.
- **ignoreip**: Lista de IPs que no serán bloqueadas (puedes agregar tu IP aquí para evitar ser bloqueado accidentalmente).
- **destemail**: Dirección de correo electrónico donde se enviarán las notificaciones.
- **sender**: Dirección de correo electrónico del remitente.
- **action**: Acción a realizar cuando se detecta un ataque (por ejemplo, enviar un correo electrónico o ejecutar un script).
### Paso 5: Habilitar y reiniciar Fail2Ban
Después de realizar los cambios en la configuración, guarda el archivo y cierra el editor. Luego, habilita y reinicia el servicio Fail2Ban para aplicar los cambios:
```bash
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### Paso 6: Archivo de configuración de ejemplo:
Aquí tienes un ejemplo de archivo `jail.local` que puedes usar como referencia:
```ini
[DEFAULT]
# Tiempo durante el cual una IP será bloqueada (10 minutos)
bantime = 600

# Tiempo durante el cual se cuentan los intentos fallidos (10 minutos)
findtime = 600

# Número máximo de intentos fallidos antes de bloquear la IP
maxretry = 5

# Lista de IPs que no serán bloqueadas (agrega tu IP aquí)
ignoreip = 127.0.0.1/8 ::1

# Acción a realizar al detectar un ataque (bloqueo con nftables)
banaction = nftables

[sshd]
# Habilitar protección para el servicio SSH
enabled = true
```
![alt text](/ANEXOS/image.png)

