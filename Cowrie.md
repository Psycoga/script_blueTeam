### Instalación y configuración de Cowrie en Kali Linux
Cowrie es un honeypot de tipo SSH y Telnet que simula un sistema vulnerable para atraer a los atacantes. A continuación, se describen los pasos para instalar y configurar Cowrie en Kali Linux.
### Paso 1: Actualizar el sistema
Antes de instalar cualquier paquete, es recomendable actualizar el sistema. Abre una terminal y ejecuta los siguientes comandos:
```bash
sudo apt update
sudo apt upgrade -y
```
### Paso 2: Instalar dependencias
Cowrie requiere varias dependencias para funcionar correctamente. Instala las siguientes dependencias:
```bash
sudo apt install python3 python3-pip python3-virtualenv libssl-dev libffi-dev build-essential -y
```
![alt text](/ANEXOS/image_cowrie.png)