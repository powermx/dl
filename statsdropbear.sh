#!/bin/bash

port_dropbear=$(ps aux | grep dropbear | awk NR==1 | awk '{print $13;}')
if [[ -z $port_dropbear ]]; then
    echo "Dropbear is not running or could not find the port."
    exit 1
fi

log="/var/log/auth.log"
loginsukses="Password auth succeeded"
echo ' '
pids=$(ps ax | grep dropbear | grep " $port_dropbear" | awk -F" " '{print $1}')
declare -A user_count
declare -A user_pid 

for pid in $pids; do
    pidlogs=$(grep $pid $log | grep "$loginsukses" | awk -F" " '{print $3}')
    for pidend in $pidlogs; do
        if [[ $pidend ]]; then
            login=$(grep $pid $log | grep "$pidend" | grep "$loginsukses")
            user=$(echo $login | awk -F" " '{print $10}' | sed -r "s/'/ /g")
            if [[ -n "${user}" ]]; then
                (( user_count[$user]++ ))
                user_pid[$user]=$pid
            fi
        fi
    done
done
echo "Usuario           Pid          Cantidad"
for user in "${!user_count[@]}"; do
    printf "%-16s %-12s %-8s\n" "$user" "${user_pid[$user]}" "${user_count[$user]}"
done
echo ""
