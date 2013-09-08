#!/bin/sh

if [ -z "$1" ]; then  
    echo "$0: called with no interface" 1>&2  
    exit 1;  
fi

# Fake ifupdown environment  
export IFACE="$1"

[ "$2" != "up" ] && exit 0

# Env  
[ ! -x /sbin/iwconfig ] && exit 0  
. /etc/freewifi.conf || exit 0


! /sbin/iwconfig "$IFACE" 2>&1|grep -i freewifi 2>&1 && logger "Ce n'est pas FreeWifi ..." && exit 0

action=`wget -O - "https://wifi.free.fr/" 2>/dev/null| sed -n '/action=/s/.*action="\(.*\)".*/\1/p'`  
wget -O - --post-data="login=$LOGIN&password=$PASSWORD" "https://wifi.free.fr"$action 2>/dev/null|grep "CONNEXION AU SERVICE REUSSIE" 1>/dev/null 2>&1 && logger "Connection FreeWifi OK" && exit 0  
logger "Erreur de connection FreeWifi"  
exit 1

