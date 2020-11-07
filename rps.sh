#/bin/bash

# Rock Paper Scissors
#hw 3

clear

echo "Welcome to the rock-paper-scissors game"
echo "You are playing against the computer"

sleep 3s

clear

while [[ true ]]; do

	clear

	echo "1 - rock, 2 - paper, 3 - scissors, 0 - exit "
	echo "Your choice: "
	read input

	re='^[0-9]+$'
	if ! [[ $input =~ $re ]] ; then
	   echo "Please, input number"
		 sleep 1.5s
		 continue
	elif [[ input -eq 0 ]]; then
		clear
		exit
	elif [[ input -gt 3 ]]; then
		echo "Please, input number equal or less then 3"
		sleep 1.5s
		continue
	elif [[ input -lt 0 ]]; then
		echo "Please, input number equal or bigger then 0"
		sleep 1.5s
		continue
	fi

	let chance=$(($RANDOM%100))

	if [[ chance -le 56 ]]; then

		if [[ input -eq 1 ]]; then
			echo -e "PC choice:\n2"
			echo "PC win! (foul play)"
		elif [[ input -eq 2 ]]; then
			echo -e "PC choice:\n3"
			echo "PC win! (foul play)"
		else
			echo -e "PC choice:\n1"
			echo "PC win! (foul play)"
		fi

	else
		let generate=$((($RANDOM)%3+1))

		if [[ "$input" -eq "$generate"  ]]; then
			echo -e "PC choice:\n$generate"
			echo "Standoff"
		elif [ "$input" -eq  1 -a "$generate" -eq 2 -o "$input" -eq 2 -a "$generate" -eq 3 -o "$input" -eq 3 -a  "$generate" -eq 1 ]; then
			echo -e "PC choice:\n$generate"
			echo "You win!"
		else
			echo -e "PC choice:\n$generate"
			echo "PC win! (fair game)"
		fi

	fi

sleep 2.5s

done
