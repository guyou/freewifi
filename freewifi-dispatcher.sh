#!/bin/sh

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# A script for NetworkManager dispatcher.
# Should be copied to:
# /etc/NetworkManager/dispatcher.d/freewifi-dispatcher.sh
    
if [ -z "$1" ]; then  
    echo "$0: called with no interface" 1>&2  
    exit 1;  
fi

# Fake ifupdown environment  
export IFACE="$1"

[ "$2" != "up" ] && exit 0

# Env  
[ ! -x /sbin/iwconfig ] && exit 0  

# SSID check
! /sbin/iwconfig "$IFACE" 2>&1 | grep -i freewifi 2>&1 && logger "Ce n'est pas FreeWifi ..." && exit 0

# Effective registering
freewifi-register.sh 2>&1 && logger "Connection FreeWifi OK" && exit 0  
logger "Erreur de connection FreeWifi"  
exit 1

