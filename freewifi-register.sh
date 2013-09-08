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


# Env  
. /etc/freewifi.conf || exit 1

# Effective registering
action=`wget -O - "https://wifi.free.fr/" 2>/dev/null | sed -n '/action=/s/.*action="\(.*\)".*/\1/p'`  
wget -O - --post-data="login=$LOGIN&password=$PASSWORD" "https://wifi.free.fr"$action 2>/dev/null | grep "CONNEXION AU SERVICE REUSSIE" 1>/dev/null 2>&1 && echo >&2 "Connection FreeWifi OK" && exit 0  
echo >&2 "Erreur de connection FreeWifi"  
exit 1
