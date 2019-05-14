#!/bin/bash

if [ -z "$1" ]; then
		echo "Enter some server domain fo which SSL expiry date needs to be fetched"
else

my_string=$1
substring=https://
if [ "${my_string/$substring}" = "$my_string" ] ; then
  host=$1
else
  host=$(echo "$1" | awk -F'://' '{print $2}')

fi


if [ -z "$port" ]; then
		port=443
fi

if [ -z "$ip" ]; then
		ip=$host
fi

hostcheck=$(openssl s_client -servername "$host" -connect "$ip":"$port" 2>&- | openssl x509 -enddate -noout)
while [ "${?}" = "1" ]; do
		echo "Check Hostname"
		exit 2
	done

datexpire=$(echo "$hostcheck" | sed 's/^notAfter=//g')

echo $datexpire
fi
