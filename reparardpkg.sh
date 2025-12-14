#!/bin/bash

LOCK_FILE="/var/lib/dpkg/lock-frontend"

echo "🔍 Verificando bloqueo de dpkg..."

if fuser "$LOCK_FILE" &>/dev/null; then
    PID=$(fuser "$LOCK_FILE" 2>/dev/null | tr -d ' ')

    echo "⚠️ dpkg/apt está bloqueado por el proceso PID: $PID"
    echo "📌 Información del proceso:"
    ps -fp "$PID"

    echo
    read -p "❓ ¿Deseas matar este proceso? [s/N]: " RESP

    if [[ "$RESP" =~ ^[sS]$ ]]; then
        echo "🛑 Matando proceso $PID..."
        kill "$PID" 2>/dev/null
        sleep 2

        if ps -p "$PID" &>/dev/null; then
            echo "⚠️ No murió, forzando kill -9..."
            kill -9 "$PID"
        fi
    else
        echo "❌ Operación cancelada por el usuario"
        exit 1
    fi
else
    echo "✅ No hay bloqueo de dpkg"
fi

echo
echo "🧹 Reparando dpkg..."
dpkg --configure -a

echo
echo "📦 Actualizando repositorios..."
apt-get update

echo
echo "⬆️ Actualizando sistema..."
apt-get upgrade -y

echo
echo "✅ Proceso completado correctamente"
