#!/bin/bash
set -e

# === Variables ===
NGINX_VERSION=1.24.0
INSTALL_DIR=/usr/local/nginx
CONF_FILE=/etc/nginx/nginx.conf
HLS_DIR=/var/www/html/hls

echo "[+] Instalando dependencias..."
apt update
apt install -y build-essential libpcre3 libpcre3-dev libssl-dev zlib1g-dev git wget curl

echo "[+] Descargando nginx $NGINX_VERSION..."
cd /usr/local/src
rm -rf nginx-$NGINX_VERSION nginx-rtmp-module
wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz
tar -zxvf nginx-$NGINX_VERSION.tar.gz
git clone https://github.com/arut/nginx-rtmp-module.git

echo "[+] Compilando nginx con módulo RTMP..."
cd nginx-$NGINX_VERSION
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module
make
make install

echo "[+] Reemplazando nginx del sistema..."
systemctl stop nginx || true
mv /usr/sbin/nginx /usr/sbin/nginx.old.$(date +%s) || true
cp $INSTALL_DIR/sbin/nginx /usr/sbin/nginx

echo "[+] Creando carpeta HLS..."
mkdir -p $HLS_DIR
chown -R www-data:www-data $HLS_DIR

echo "[+] Escribiendo configuración en $CONF_FILE..."
cat > $CONF_FILE <<'EOF'
user www-data;
worker_processes auto;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile      on;
    keepalive_timeout  65;

    server {
        listen 8443;
        server_name _;

        location / {
            root /var/www/html;
            index index.html;
        }

        location /hls {
            types {
                application/vnd.apple.mpegurl m3u8;
                video/mp2t ts;
            }
            root /var/www/html;
            add_header Cache-Control no-cache;
            add_header Access-Control-Allow-Origin *;
        }
    }
}

rtmp {
    server {
        listen 80;
        chunk_size 4096;

        application live {
            live on;
            record off;

            hls on;
            hls_path /var/www/html/hls;
            hls_fragment 3;
            hls_playlist_length 60;
            allow publish all;
            allow play all;
        }
    }
}
EOF

echo "[+] Creando servicio systemd..."
cat > /lib/systemd/system/nginx.service <<'EOF'
[Unit]
Description=The NGINX HTTP and reverse proxy server with RTMP
After=network.target

[Service]
PIDFile=/var/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx -c /etc/nginx/nginx.conf
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/usr/sbin/nginx -s quit


[Install]
WantedBy=multi-user.target
EOF

mkdir -p /var/run
touch /var/run/nginx.pid
chown www-data:www-data /var/run/nginx.pid


echo "[+] Página de prueba..."
cat > /var/www/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Stream RTMP → HLS</title>
  <script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
</head>
<body style="background:#000; text-align:center; color:#fff;">
  <h2>Transmisión en vivo</h2>
  <video id="video" controls autoplay width="720"></video>
  <script>
    var video = document.getElementById('video');
    if (Hls.isSupported()) {
      var hls = new Hls();
      hls.loadSource('http://' + window.location.hostname + ':8443/hls/stream.m3u8');
      hls.attachMedia(video);
    } else if (video.canPlayType('application/vnd.apple.mpegurl')) {
      video.src = 'http://' + window.location.hostname + ':8443/hls/stream.m3u8';
    }
  </script>
</body>
</html>
EOF

echo "[+] Habilitando y arrancando nginx..."
systemctl daemon-reload
systemctl enable nginx
systemctl restart nginx

echo "======================================="
echo " Instalación completa!"
echo " - RTMP: rtmp://<IP>:8443/live"
echo " - Pass: stream"
echo " - HLS:  http://<IP>:8443/hls/stream.m3u8"
echo " - Página: http://<IP>:80/"
echo "======================================="
