#!/bin/bash
echo -e "Instalando ruta: /etc/rc.local"
if [ "$EUID" -ne 0 ]; then
  echo "Este script debe ejecutarse como root."
  exit 1
fi

cat <<EOF > /etc/systemd/system/rc-local.service
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99

[Install]
WantedBy=multi-user.target
EOF

if [ ! -f /etc/rc.local ]; then
  cat <<EOF > /etc/rc.local
#!/bin/sh -e
#
# rc.local
#
#
exit 0
EOF
fi

chmod +x /etc/rc.local
systemctl daemon-reexec
systemctl enable rc-local
systemctl start rc-local.service
systemctl status rc-local.service
