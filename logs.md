### Descripción del script
Este script permite descargar logs de un servidor remoto utilizando SSH y `sshpass` para la autenticación. El usuario puede elegir entre descargar logs comunes del sistema o especificar un log en particular. Los logs se guardan en una carpeta local con la fecha y hora actual.
### Requisitos
- `sshpass`: Para facilitar la autenticación SSH sin necesidad de ingresar la contraseña manualmente.
- `scp`: Para copiar archivos de forma segura entre el servidor remoto y la máquina local.
### Uso
1. Asegúrate de tener `sshpass` instalado en tu sistema. Puedes instalarlo con:
   ```bash
   sudo apt install sshpass
   ```
2. Guarda el script en un archivo, por ejemplo `descargar_logs.sh`.

3. Dale permisos de ejecución:
   ```bash
   chmod +x descargar_logs.sh
   ```
4. Ejecuta el script:
   ```bash
   ./descargar_logs.sh
   ```
### Notas
- Asegúrate de tener acceso SSH al servidor remoto y de que el usuario tenga permisos para leer los logs.
- El script crea una carpeta `logs_backup` en el directorio actual para almacenar los logs descargados.


```bash
#!/bin/bash

# Solicitar datos de conexión
read -p "👉 IP del servidor: " IP
read -p "👤 Usuario: " USUARIO
read -s -p "🔑 Contraseña: " CONTRASENA
echo

# Validar formato de IP
if [[ ! $IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    echo "❌ IP no válida. Por favor, verifica el formato."
    exit 1
fi

# Crear carpeta para guardar los logs
CARPETA_LOCAL="./logs_backup/$(date "+%Y-%m-%d_%H-%M")"
mkdir -p "$CARPETA_LOCAL"

# Menú de opciones
echo
echo "📋 Opciones:"
echo "1) Descargar logs comunes del sistema"
echo "2) Descargar un log específico"
read -p "Elige una opción (1 o 2): " OPCION

# Configurar logs a descargar
if [[ "$OPCION" == "1" ]]; then
    LOGS=("syslog" "auth.log" "dmesg")
    RUTA_REMOTA="/var/log/"
elif [[ "$OPCION" == "2" ]]; then
    read -p "Escribe la ruta completa del log (ej: /var/log/apache2/access.log): " LOG_PERSONAL
    LOGS=($(basename "$LOG_PERSONAL"))
    RUTA_REMOTA=$(dirname "$LOG_PERSONAL")/
else
    echo "❌ Opción no válida. Saliendo..."
    exit 1
fi

# Descargar logs
for LOG in "${LOGS[@]}"; do
    echo "⬇️ Descargando: $LOG"
    sshpass -p "$CONTRASENA" scp "$USUARIO@$IP:$RUTA_REMOTA$LOG" "$CARPETA_LOCAL/" 2>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "⚠️ No se pudo descargar $LOG. Verifica permisos o existencia."
    else
        echo "✅ $LOG descargado con éxito."
    fi
done

echo
echo "📁 Logs guardados en: $CARPETA_LOCAL"
´´´

