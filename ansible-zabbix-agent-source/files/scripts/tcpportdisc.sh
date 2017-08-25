#!/bin/bash
local_path=`dirname $0`
portarray=(`netstat -tnlp|egrep -i "$1"|awk {'print $4'}|awk -F':' '{if ($NF~/^[0-9]*$/) print $NF}'|sort |uniq   2>/dev/null`)
length=${#portarray[@]}
printf "{\n"
printf  '\t'"\"data\":["
for ((i=0;i<$length;i++));do
     for j in $(<$local_path/portlist.txt);do
        if [ $j -eq ${portarray[$i]} ];then
        printf '\n\t\t{'
        printf "\"{#TCP_PORT}\":\"$j\"},"
         fi
     done
done
printf "\n\t\t{\"{#TCP_PORT}\":\"22\"}"
printf  "\n\t]\n"
printf "}\n"
