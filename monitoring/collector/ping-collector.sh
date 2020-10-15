#!/bin/bash

while true 
do
  TEXTFILE_COLLECTOR_DIR=/var/lib/ping_collector
  INTERNALIP=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
  IPLIST=$(cat /home/ec2-user/ips.txt)
  IFS=,

  # Check if folder exists, if not, it'll be created
  if [ ! -d $TEXTFILE_COLLECTOR_DIR ]
  then
    mkdir $TEXTFILE_COLLECTOR_DIR
  fi

  for ip in $IPLIST
  do
    ip=$(echo "$ip" | awk -v RS='([0-9]+\\.){3}[0-9]+' 'RT{print RT}')

    if [ "$ip" == "${INTERNALIP}" ];
    then
      SOURCE="$ip"
    elif [ "$TARGET1" == "" ];
    then
      TARGET1="$ip"
    else
      TARGET2="$ip"
    fi
  done

  ping -c1 "$TARGET1" > ping-target1.txt
  TIME_TARGET1=$(sed -n '2{p;q}' ping-target1.txt | awk 'BEGIN {FS="[=]|[ ]"} {print $10}')

  ping -c1 "$TARGET2" > ping-target2.txt
  TIME_TARGET2=$(sed -n '2{p;q}' ping-target2.txt | awk 'BEGIN {FS="[=]|[ ]"} {print $10}')

  # Write out metrics to a temporary file.
  cat << EOF > "$TEXTFILE_COLLECTOR_DIR/ping.prom.$$"
  # HELP ping_current_time_ms Current ping time in milliseconds
  # TYPE ping_current_time_ms gauge
  ping_current_time_ms{source="${SOURCE}",target="${TARGET1}"} ${TIME_TARGET1}
  ping_current_time_ms{source="${SOURCE}",target="${TARGET2}"} ${TIME_TARGET2}
EOF

  # Rename the temporary file atomically.
  # This avoids the node exporter seeing half a file.
  mv -f "$TEXTFILE_COLLECTOR_DIR/ping.prom.$$" \
    "$TEXTFILE_COLLECTOR_DIR/ping.prom"
  
  sleep 5;
done