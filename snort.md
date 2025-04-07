### Instalación y configuración de Snort en Kali Linux
Snort es un sistema de detección de intrusos (IDS) de código abierto que se utiliza para monitorear el tráfico de red en tiempo real y detectar actividades sospechosas. A continuación, se describen los pasos para instalar y configurar Snort en Kali Linux.
### Paso 1: Actualizar el sistema
Antes de instalar cualquier paquete, es recomendable actualizar el sistema. Abre una terminal y ejecuta los siguientes comandos:
```bash
sudo apt update
sudo apt upgrade -y
```
### Paso 2: Instalar Snort
Para instalar Snort, ejecuta el siguiente comando en la terminal:
```bash
sudo apt install snort -y
```
### Paso 3: Configurar Snort
Snort utiliza un archivo de configuración principal que se encuentra en `/etc/snort/snort.conf`. Antes de editar este archivo, es recomendable hacer una copia de seguridad:
```bash
sudo cp /etc/snort/snort.conf /etc/snort/snort.conf.bak
```
Luego, abre el archivo de configuración con un editor de texto, por ejemplo, `nano`:
```bash
sudo nano /etc/snort/snort.conf
```
Dentro de este archivo, puedes configurar las siguientes opciones:

![alt text](/ANEXOS/image_snort2.png)

### Paso 4: Configurar las reglas
Asegúrate de que Snort cargue las reglas necesarias. Busca la sección donde se incluyen las reglas y verifica que las líneas no estén comentadas (sin # al inicio). Por ejemplo:

```
include $RULE_PATH/local.rules
include $RULE_PATH/community.rules
```
### Paso 5: Probar la configuración
Para verificar que la configuración de Snort es correcta, ejecuta el siguiente comando:
```bash
sudo snort -T -c /etc/snort/snort.conf
```
Si no hay errores, verás un mensaje que indica que la configuración es correcta.

![alt text](/ANEXOS/image_snort.png)