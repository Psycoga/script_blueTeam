### Seguridad SSH en Kali Linux
El protocolo SSH es una herramienta fundamental para la administración remota de servidores. Sin embargo, es importante implementar medidas de seguridad para protegerlo contra accesos no autorizados. A continuación, se describen los pasos para asegurar SSH en Kali Linux.

### Paso 1: Actualizar el sistema
Antes de realizar cualquier configuración, es recomendable actualizar el sistema. Abre una terminal y ejecuta los siguientes comandos:
```bash
sudo apt update
sudo apt upgrade -y
```

### Paso 2: Configurar el archivo sshd_config
El archivo principal de configuración de SSH se encuentra en `/etc/ssh/sshd_config`. Abre este archivo con un editor de texto, por ejemplo, `nano`:
```bash
sudo nano /etc/ssh/sshd_config
```

Dentro de este archivo, realiza las siguientes configuraciones básicas para mejorar la seguridad:
- **Cambiar el puerto por defecto**: Cambia el puerto 22 por otro puerto no estándar (por ejemplo, 2222):
  ```bash
  Port 2222
  ```
- **Deshabilitar el acceso root directo**: Evita que el usuario root pueda iniciar sesión directamente:
  ```bash
  PermitRootLogin no
  ```
- **Permitir solo autenticación por clave pública**: Deshabilita las contraseñas y usa claves SSH:
  ```bash
  PasswordAuthentication no
  PubkeyAuthentication yes
  ```
- **Especificar usuarios permitidos**: Limita el acceso SSH a usuarios específicos:
  ```bash
  AllowUsers usuario1 usuario2
  ```

![alt text](/ANEXOS/image_ssh_seguro.png)

Guarda los cambios y cierra el archivo.

### Paso 3: Reiniciar el servicio SSH
Después de realizar los cambios, reinicia el servicio SSH para aplicarlos:
```bash
sudo systemctl restart ssh
```

### Paso 4: Configurar un firewall con UFW
Usa UFW para permitir solo el puerto configurado para SSH. Por ejemplo, si cambiaste el puerto a 2222:
```bash
sudo ufw allow 2222/tcp
sudo ufw enable
```

### Paso 5: Configurar Fail2Ban para proteger SSH
Fail2Ban puede bloquear direcciones IP después de varios intentos fallidos de inicio de sesión. Instálalo y configúralo de la siguiente manera:
```bash
sudo apt install fail2ban -y
```

Edita el archivo de configuración local de Fail2Ban:
```bash
sudo nano /etc/fail2ban/jail.local
```

Agrega la siguiente configuración para proteger SSH:
```ini
[sshd]
enabled = true
port = 2222
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
bantime = 600
```

Guarda los cambios y reinicia Fail2Ban:
```bash
sudo systemctl restart fail2ban
```

### Paso 6: Probar la configuración
1. Intenta conectarte al servidor usando el nuevo puerto SSH:
   ```bash
   ssh -p 2222 usuario@<IP_DEL_SERVIDOR>
   ```
2. Verifica que el acceso root esté deshabilitado y que las claves públicas funcionen correctamente.

### Paso 7: Monitorear los registros
Revisa los registros de SSH para detectar intentos de acceso no autorizados:
```bash
sudo tail -f /var/log/auth.log
```

### Conclusión
Con estas configuraciones, tu servidor SSH estará mejor protegido contra accesos no autorizados. Recuerda monitorear regularmente los registros y actualizar el sistema para mantener la seguridad.