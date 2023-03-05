#! /bin/bash
TARGETHOUR=6
SAMPLESIZE=100
SAMPLEFORCE=11
INIT=60
MAX=95
GAP=5
	x=$(echo "usage=$(cat /sys/class/power_supply/BAT0/power_now); left=$(cat /sys/class/power_supply/BAT0/energy_now);  $TARGETHOUR*usage*100/left" | bc -l)
	VAL=${x%.*}
	VAL=$(($VAL))

repeat(){
	for i in {1..$SAMPLEFORCE}; do echo -n "$1" >> /home/kerem/.scripts/input.txt ; done
}
#	echo $VAL
	if [[ $VAL -eq 0 || $VAL -gt 400 ]] ; then
		:
#		echo charging
	else
		if [[ $VAL -le $MAX && $VAL -ge $INIT ]] ; then
			echo "$VAL"
#			/usr/bin/doas tpacpi-bat -s SP 0 $VAL
#			/usr/bin/doas tpacpi-bat -s ST 0 $(($VAL-$GAP))

		else
			if [ $VAL -gt $MAX ] ; then
			echo "$MAX"
			VAL=$MAX
#			/usr/bin/doas tpacpi-bat -s SP 0 $MAX
#			/usr/bin/doas tpacpi-bat -s ST 0 $(($MAX-$GAP))
			else
				if [ $VAL -lt $INIT ] ; then
				echo "$INIT"
				VAL=$INIT
#				/usr/bin/doas tpacpi-bat -s SP 0 $INIT
#				/usr/bin/doas tpacpi-bat -s ST 0 $(($INIT-$GAP))
				fi
			fi
		fi
		
		tail -12 /home/kerem/.scripts/log.txt > /home/kerem/.scripts/input.txt
		repeat "$VAL"
		AVG=$(awk '{s+=$1}END{print s/NR}' /home/kerem/.scripts/log.txt )
		echo $AVG #>> input.txt
		AVGALL=$(awk '{s+=$1}END{print s/NR}' /home/kerem/.scripts/input.txt )
		echo $AVGALL
		AVGALL=${$AVGALL%.*}
		AVGALL=$(($AVGALL))
		/usr/bin/doas tpacpi-bat -s SP 0 $AVGALL
		/usr/bin/doas tpacpi-bat -s ST 0 $(($AVGALL-$GAP))
		
	fi