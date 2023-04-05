#!/usr/bin/env bash
let THRESHOLD=30

greenText="\033[32m"
yellowText="\033[33m"
warningText="\033[43m"
normal="\033[0m"

# If no arguments provides used default threshold
if [ $# -gt 0 ] ; then
    if [[ $1 =~ ^-?[0-9]+([0-9]+)?$ ]] ; then
        THRESHOLD=$1
    fi
fi


df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $1,$2,$4,$5}' | while read data
do
    partition=$(echo $data | awk '{print $1}')
    total=$(echo $data | awk '{print $2}')
    available=$(echo $data | awk '{print $3}')
    used=$(echo $data | awk '{print $4}' | sed s/%//g) # Removed percent symbol using sed
    if [ $used -ge $THRESHOLD ]
    then
        echo -e "$warningText WARNING:$normal Partition \"$partition\" has used $used% of $total Available Space:$greenText $available $normal"
    fi
done
