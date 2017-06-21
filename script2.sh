#!/bin/bash

clear

xml=$(cat systemstats.xml)

CPULOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
echo $CPULOAD
MEMLOAD=$(free | grep Mem | awk '{print $3/$2 * 100.0"%"}')
echo $MEMLOAD
user=$(echo "$xml" | sed -n '/<user>/,/<\/user>/p')
process=$(echo "$xml" | sed -n '/<process>/,/<\/process>/p')
for who in $(who | cut -d' ' -f1 | sort | uniq); 
do
	userBlock+=${user/<username>/<username>$who}
	ps -u $who | awk '{print $1, $2}' | \
	while read var1 var2; do
		echo -n "PID: " $var1
		echo " CMD:" $var2l
		processBlock=${process/<pid>/<pid>$var1}
		processBlock=${process/<cmd>/<cmd>$var2}
		processList+=processBlock
	done
echo "$processBlock"
userBlock+=$(echo "$xml" | sed -n '/<process>/,/<\/process>/p' <<< "$processBlock")
		echo "userBlock"
echo "$userBlock"
done
$xml=$(echo "$xml" | sed -i 's/(<user>).*(</user>)/\1 <user>$userBlock \2/g')
DATE=$(date +%Y-%m-%d)
WEEKDAY=$(date +%u)
TIME=$(date +"%T")
xml=${xml/<date>/<date>$DATE}
xml=${xml/<weekday>/<weekday>$WEEKDAY}
xml=${xml/<time>/<time>$TIME}
xml=${xml/<cpuload>/<cpuload>$CPULOAD}
xml=${xml/<memload>/<memload>$MEMLOAD}
#$(git checkout details)
#$(git commit -m "report")
#$(git push origin master)

echo $xml > systemstats3.xml

