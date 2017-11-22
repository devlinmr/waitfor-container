#!/bin/sh

# comma-delimited list of host:port,host:port
if [ -z ${HOSTPORT} ] || "x${HOSTPORT}x" == "xx" ]; then
  exit 0
fi

IFS=','
for target in ${HOSTPORT}; do
    echo "Checking $target..."
    host=`echo ${target} | awk -F: '{print $1}'`
    port=`echo ${target} | awk -F: '{print $2}'`
    while ! `nc -z -w 2 $host $port`; do
        echo "Waiting on host: ${host} port: ${port}..."
    done
done

exit 0
