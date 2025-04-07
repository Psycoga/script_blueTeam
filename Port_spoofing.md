### Instalación y configuración de Portspoof en Kali Linux
Portspoof es una herramienta diseñada para proteger los puertos abiertos de un sistema al simular servicios en puertos no utilizados. Esto puede confundir a los atacantes y dificultar la identificación de servicios reales. A continuación, se describen los pasos para instalar y configurar Portspoof en Kali Linux.

---

### Paso 1: Actualizar el sistema
Antes de comenzar, es importante asegurarse de que el sistema esté actualizado. Abre una terminal y ejecuta los siguientes comandos:
```bash
sudo apt update
sudo apt upgrade -y
```

---

### Paso 2: Instalar dependencias necesarias
Portspoof requiere ciertas herramientas y bibliotecas para compilarse correctamente. Instálalas con el siguiente comando:
```bash
sudo apt install git build-essential iptables -y
```

---

### Paso 3: Clonar el repositorio de Portspoof
Clona el repositorio oficial de Portspoof desde GitHub:
```bash
git clone https://github.com/drk1wi/portspoof.git
cd portspoof/
```

---

### Paso 4: Compilar e instalar Portspoof
Compila e instala Portspoof ejecutando los siguientes comandos:
```bash
./configure
make
sudo make install
make clean
```

---

### Paso 5: Configurar Portspoof
Crea un directorio para los archivos de configuración de Portspoof y mueve los archivos necesarios:
```bash
sudo mkdir -p /etc/portspoof
sudo cp tools/portspoof.conf /etc/portspoof/
sudo cp tools/portspoof_signatures /etc/portspoof/
```

Edita el archivo de configuración `/etc/portspoof/portspoof.conf` para personalizarlo. Por ejemplo:
```bash
sudo nano /etc/portspoof/portspoof.conf
```

Ejemplo de configuración básica:
```plaintext
bind_port = 1-65535
default_app_banner = "Este puerto está protegido por Portspoof."
logfile = /var/log/portspoof.log
```

---

### Paso 6: Configurar iptables
Configura `iptables` para redirigir todos los puertos no utilizados a Portspoof. Por ejemplo:
```bash
sudo iptables -t nat -A PREROUTING -p tcp --dport 1:65535 -j REDIRECT --to-ports 4444
```

Si deseas permitir el acceso a un puerto específico (como SSH), asegúrate de agregar una regla antes:
```bash
sudo iptables -t nat -A PREROUTING -p tcp --dport 22 -j ACCEPT
```

---

### Paso 7: Iniciar Portspoof
Inicia Portspoof con el siguiente comando:
```bash
sudo portspoof -c /etc/portspoof/portspoof.conf -s /etc/portspoof/portspoof_signatures
```

Para ejecutarlo en segundo plano:
```bash
sudo portspoof -c /etc/portspoof/portspoof.conf -s /etc/portspoof/portspoof_signatures &
disown
```

---

### Paso 8: Verificar la configuración
Prueba la configuración intentando conectarte a un puerto simulado. Por ejemplo:
```bash
telnet <IP_DEL_SERVIDOR> 1234
```

Revisa los registros generados por Portspoof:
```bash
sudo tail -f /var/log/portspoof.log
```

---

### Paso 9: Eliminar reglas de iptables (opcional)
Si deseas eliminar las reglas de redirección de `iptables`, usa el siguiente comando:
```bash
sudo iptables -t nat -D PREROUTING -p tcp --dport 1:65535 -j REDIRECT --to-ports 4444
```

---

### Notas finales
- **Alias útil:** Puedes crear un alias para iniciar Portspoof fácilmente. Por ejemplo:
  ```bash
  alias iniciafakep="sudo portspoof -c /etc/portspoof/portspoof.conf -s /etc/portspoof/portspoof_signatures"
  ```
- **Advertencia:** Si detienes Portspoof sin eliminar las reglas de `iptables`, podrías perder acceso a servicios importantes como SSH.

Con esta configuración, Portspoof estará listo para proteger tu sistema simulando servicios en puertos no utilizados.