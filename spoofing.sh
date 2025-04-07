#!/bin/bash

# Lista de paquetes a instalar
paquetes=("git" "make" "g++" "iptables")

# Función para verificar si un paquete está instalado (Debian/Ubuntu/Kali)
paquete_instalado_apt() {
    dpkg -l "$1" | grep -q '^ii'  
}

# Función para verificar si un paquete está instalado (CentOS/RHEL)
paquete_instalado_yum() {
    yum list installed "$1" &> /dev/null
}

# Función para verificar si un paquete está instalado (Fedora)
paquete_instalado_dnf() {
    dnf list installed "$1" &> /dev/null
}

# Función para verificar si un paquete está instalado (Arch Linux)
paquete_instalado_pacman() {
    pacman -Qi "$1" &> /dev/null
}

# Detectar el sistema operativo
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
fi

# Instalar paquetes basados en el sistema operativo
for paquete in "${paquetes[@]}"; do
    case $OS in
        "debian"|"ubuntu"|"kali")
            if ! paquete_instalado_apt "$paquete"; then
                echo "Instalando el paquete $paquete..."
                sudo apt-get install -y "$paquete"
            fi
            ;;
        "centos"|"rhel")
            if ! paquete_instalado_yum "$paquete"; then
                echo "Instalando el paquete $paquete..."
                sudo yum install -y "$paquete"
            fi
            ;;
        "fedora")
            if ! paquete_instalado_dnf "$paquete"; then
                echo "Instalando el paquete $paquete..."
                sudo dnf install -y "$paquete"
            fi
            ;;
        "arch")
            if ! paquete_instalado_pacman "$paquete"; then
                echo "Instalando el paquete $paquete..."
                sudo pacman -S --noconfirm "$paquete"
            fi
            ;;
        *)
            ;;
    esac
done

# Preguntar por el puerto SSH
read -p "Ingrese el puerto que usa SSH: " ssh_port

# Clonar el repositorio de Portspoof
git clone https://github.com/drk1wi/portspoof.git
cd portspoof/

# Compilar e instalar Portspoof
./configure
make
sudo make install
make clean

# Crear directorio para la configuración de Portspoof y mover archivos
sudo mkdir -p /etc/portspoof
sudo mv tools/portspoof.conf /etc/portspoof/
sudo mv tools/portspoof_signatures /etc/portspoof/

# Verificar el movimiento de los archivos
echo "Files moved to /etc/portspoof:"
ls /etc/portspoof
echo ""

echo -e "\n\033[1;31m_____________SSH will stop working after stopping Portspoof.____________________________\033[0m\n"

# Preguntar si iniciar Portspoof
read -p "Do you want to start Portspoof now? [y/n] " answer

if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    # Asegurar que el puerto SSH esté permitido
    sudo iptables -t nat -A PREROUTING -p tcp --dport "$ssh_port" -j ACCEPT
    
    # Redirigir los demás puertos
    sudo iptables -t nat -A PREROUTING -p tcp --dport 1:65535 -j REDIRECT --to-ports 4444
    
    # Iniciar Portspoof
    portspoof -c /etc/portspoof/portspoof.conf -s /etc/portspoof/portspoof_signatures &
    disown
fi

echo -e "\n\033[1;34m_________________________________________________________\033[0m\n"

echo "Iptables rules to add or remove:"
echo "sudo iptables -t nat -A PREROUTING -p tcp --dport 1:65535 -j REDIRECT --to-ports 4444"
echo "To delete the rule next command: (SSH might not work if it's enabled.)"
echo "sudo iptables -t nat -D PREROUTING -p tcp --dport 1:65535 -j REDIRECT --to-ports 4444"
echo ""
echo "To run Portspoof manually:"
echo "portspoof -c /etc/portspoof/portspoof.conf -s /etc/portspoof/portspoof_signatures"
echo "Alias to start portspoof: iniciafakep"
echo -e "\n\033[1;34m_________________________________________________________\033[0m\n"

cd ~
rm -rf portspoof
