#!/bin/bash
#Usage: ./ipcrypt.sh [IP/URL]
#Assign Input to Variable

if [[ "$1" != "" ]]; then
    INPUT="$1"
else
    INPUT=.
fi

#Sanitize Inputs

export ADDR_CLEAN="`echo "${INPUT}" | sed 's/\<http\>//g' | sed 's/\<https\>//g' | sed 's/www.//g' | tr -d :/ `"

#Detect if IP, if not, attempt to find host

if ! [[ $ADDR_CLEAN =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
   HOST=$(host $ADDR_CLEAN | head -1)
   ADDR_CLEAN=$(echo $HOST | sed 's/.* //';)
fi

echo "IP: $ADDR_CLEAN"

#Binary

BIN=$(echo $ADDR_CLEAN | tr '.' ' ' | while read octet1 octet2 octet3 octet4
do
echo "2 o $octet1 p $octet2 p $octet3 p $octet4 p" | dc | tr '\n' '.'
done)
echo "Binary: "${BIN%?}""

#Decimal

DEC=$(ip=$ADDR_CLEAN
    IFS=. read -r a b c d <<< "$ip"
    printf '%d\n' "$((a * 256 ** 3 + b * 256 ** 2 + c * 256 + d))"
)
echo "Decimal: $DEC"

#Hexadecimal Single String

for HEX
do
    HEX=$(printf '%02X' ${ADDR_CLEAN//./ })
done
echo "Hexadecimal A: 0x$HEX"

#Period Delimited Conversions, Hex and Oct

#IP Cut

    IP1=$(echo $ADDR_CLEAN | cut -f1 -d.)
    IP2=$(echo $ADDR_CLEAN | cut -f2 -d.)
    IP3=$(echo $ADDR_CLEAN | cut -f3 -d.)
    IP4=$(echo $ADDR_CLEAN | cut -f4 -d.)

#Hexadecimal B

for HEX
do
    HEX1=$(printf '%02X' ${IP1//./ })
    HEX2=$(printf '%02X' ${IP2//./ })
    HEX3=$(printf '%02X' ${IP3//./ })
    HEX4=$(printf '%02X' ${IP4//./ })

done
echo "Hexadecimal B: 0x$HEX1.0x$HEX2.0x$HEX3.0x$HEX4"

#Octal

for OCT
do
    OCT1=$(printf '%0o' ${IP1//./ })
    OCT2=$(printf '%0o' ${IP2//./ })
    OCT3=$(printf '%0o' ${IP3//./ })
    OCT4=$(printf '%0o' ${IP4//./ })

    OCT5=$(printf %03d $OCT1)
    OCT6=$(printf %03d $OCT2)
    OCT7=$(printf %03d $OCT3)
    OCT8=$(printf %03d $OCT4)
done
echo "Octal: 0$OCT5.0$OCT6.0$OCT7.0$OCT8"
