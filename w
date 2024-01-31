#!/bin/bash
clear
pkill -f ws-epro
echo INSTALANDO PHYTON NUEVO
sleep 1
cd

#Install ws-epro
wget -q -O /usr/local/bin/ws-epro "https://raw.githubusercontent.com/tridebleng/dxo/ipuk/Resource/Core/ws-epro";
chmod +x /usr/local/bin/ws-epro

#ws-epro service
wget -q -O /etc/systemd/system/ws-epro.service "https://raw.githubusercontent.com/tridebleng/dxo/ipuk/Resource/Service/ws-epro_service";
chmod +x /etc/systemd/system/ws-epro.service

#ws-epro port
wget -q -O /usr/bin/ws-port "https://raw.githubusercontent.com/powermx/dl/master/ws-port";
chmod +x /usr/bin/ws-port

#setting port
echo SELECCIONE PUERTOS
sleep 1
read -p "PUERTO LOCAL : " openssh
read -p "PUERTO PHYTON : " wsopenssh
WS_DIR=/usr/local/etc/ws-epro
if [ -d "$WS_DIR" ]; then # if it exists,delete it.
    rm -rf "$WS_DIR"
fi
mkdir "$WS_DIR"
echo "CONFIGURANDO SERVIDOR ESPERE..."
sleep 0.5
echo "# verbose level 0=info, 1=verbose, 2=very verbose" >> /usr/local/etc/ws-epro/config.yml
echo "verbose: 0" >> /usr/local/etc/ws-epro/config.yml
echo "listen:"  >> /usr/local/etc/ws-epro/config.yml

#seting port
echo "##openssh" >> /usr/local/etc/ws-epro/config.yml
echo "- target_host: 127.0.0.1" >> /usr/local/etc/ws-epro/config.yml
echo "##portopenssh" >> /usr/local/etc/ws-epro/config.yml
echo "  target_port: $openssh" >> /usr/local/etc/ws-epro/config.yml
echo "##wsopenssh" >> /usr/local/etc/ws-epro/config.yml
echo "  listen_port: $wsopenssh" >> /usr/local/etc/ws-epro/config.yml

chmod +x /usr/local/etc/ws-epro/config.yml

#Enable & Start service
systemctl enable ws-epro
systemctl start ws-epro

echo "CONFIGURE SU SERVIDOR WEBSOCKET PRO..."
sleep 0.3
clear
LP='\033[1;35m'
NC='\033[0m' # No Color
echo -e "${LP}"
echo    "
░██╗░░░░░░░██╗░██████╗░░░░░░██████╗░██████╗░░█████╗░
░██║░░██╗░░██║██╔════╝░░░░░░██╔══██╗██╔══██╗██╔══██╗
░╚██╗████╗██╔╝╚█████╗░█████╗██████╔╝██████╔╝██║░░██║
░░████╔═████║░░╚═══██╗╚════╝██╔═══╝░██╔══██╗██║░░██║
░░╚██╔╝░╚██╔╝░██████╔╝░░░░░░██║░░░░░██║░░██║╚█████╔╝
░░░╚═╝░░░╚═╝░░╚═════╝░░░░░░░╚═╝░░░░░╚═╝░░╚═╝░╚════╝░"

echo    "SCRIPT WEBSOCKET CLOUDFLARE SIN PRO E-PRO"
echo    "╔════════════════════╗"
echo    "   Puerto Local SSH: $openssh"
echo    "   Puerto Phyton: $wsopenssh"
echo    "╚════════════════════╝"
echo    ""
echo    "WEBSOCKET SIN SER PLAN PRO CLOUDFLARE"
echo    "---------------------------------------"
echo    ""
echo    "PARA CAMBIAR DE PUERTO USE COMANDO: ws-port"
echo    "---------------------------------------"
echo    ""
echo    "GET / HTTP/1.1[crlf]Host: Dominio[crlf]Upgrade: websocket[crlf][crlf]"
echo    "---------------------------------------"
echo -e "${NC}"
rm -rf install-ws && cat /dev/null > ~/.bash_history && history -c
echo -ne "\n\033[1;31mENTER \033[1;33mpara entrar al \033[1;32mVpsPack\033[0m"; read
   vpspack
   
   fi
