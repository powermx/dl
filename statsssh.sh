#!/bin/bash
for usur in `awk -F : '$3 > 900 { print $1 }' /etc/passwd |grep -v "nobody" |grep -vi polkitd |grep -vi systemd-[a-z] |grep -vi systemd-[0-9] |sort`; do
usurnum="$(ps -u $usur |grep sshd |wc -l)"
echo -e "\033[1;33m    $(printf '%-41s%s' $usur $usurnum) \033[0m"
echo -e "\033[1;37m             ─────────────────────────\033[0m"
done
